#!/usr/bin/env bash

set -euo pipefail

# ============================================================
# Configuration
# ============================================================

ROFI_CONFIG_FOLDER_LAYOUT="$HOME/.config/rofi/config/layouts/utils-selector.rasi"
ROFI_CONFIG_WALLPAPER_LAYOUT="$HOME/.config/rofi/config/layouts/wallpaper-picker.rasi"

WALLPAPER_DIR_ROOT="$HOME/Pictures/wallpapers/collections"

# NOTE: Ordered list, add the folder path you want to load!
WALL_DIRS=(
    "$WALLPAPER_DIR_ROOT/anime/chainsaw-man"
    "$WALLPAPER_DIR_ROOT/anime/jujutsu-kaisen"
    "$WALLPAPER_DIR_ROOT/anime/demon-slayer"
    "$WALLPAPER_DIR_ROOT/anime/darling-in-the-franxx"
    "$WALLPAPER_DIR_ROOT/anime/my-hero-academia"
)

CACHE_DIR="$HOME/.cache/wall-thumb"

BASE_BACKGROUND_COLOR="#0d0a0a"

MONITOR="HDMI-A-1"

# Extensions considered "animated" wallpapers
ANIMATED_REGEX='\.(mp4|gif|webm|mkv|mov)$'

STATIC_NAME_MATCH=(
    -iname "*.jpg"  -o
    -iname "*.jpeg" -o
    -iname "*.png"  -o
    -iname "*.webp"
)

ANIMATED_NAME_MATCH=(
    -iname "*.mp4"  -o
    -iname "*.gif"  -o
    -iname "*.webm" -o
    -iname "*.mkv"  -o
    -iname "*.mov"
)

mkdir -p "$CACHE_DIR"

# ============================================================
# Type detection
# ============================================================

is_animated_wallpaper() {
    local file="$1"
    [[ "${file,,}" =~ $ANIMATED_REGEX ]]
}

# ============================================================
# Thumbnail cache
# ============================================================

get_cache_path() {
    local file="$1"

    local rel
    rel="${file#$HOME/Pictures/wallpapers/}"

    local dir
    dir="$(dirname "$rel")"

    local hash
    hash="$(sha1sum "$file" | cut -d' ' -f1)"

    echo "$CACHE_DIR/$dir/$hash.jpg"
}

generate_thumbnail() {
    local file="$1"

    local thumb
    thumb="$(get_cache_path "$file")"

    mkdir -p "$(dirname "$thumb")"

    if [[ -f "$thumb" && ! "$file" -nt "$thumb" ]]; then
        return
    fi

    if is_animated_wallpaper "$file"; then
        ffmpeg -y -loglevel error \
            -i "$file" \
            -vframes 1 \
            -vf "scale=320:180:force_original_aspect_ratio=increase,crop=320:180" \
            "$thumb"
    else
        vipsthumbnail \
            "$file" \
            --size 320x180 \
            --smartcrop centre \
            --output "$thumb"
    fi
}

generate_cache() {
    for dir in "${WALL_DIRS[@]}"; do
        find "$dir" -type f \
            \( "${STATIC_NAME_MATCH[@]}" -o "${ANIMATED_NAME_MATCH[@]}" \) \
            -print0 |
        while IFS= read -r -d '' file; do
            generate_thumbnail "$file"
        done
    done
}

# ============================================================
# Folder navigation
# ============================================================

folder_preview_icon() {
  printf " "
}

select_folder() {
    {
        for dir in "${WALL_DIRS[@]}"; do
            printf "%s\0display\x1f%s %s\n" \
                "$dir" \
                "$(folder_preview_icon "$dir")" \
                "$(basename "$dir")"
        done
    } | rofi \
        -dmenu \
        -show-icons \
        -p "Wallpapers:" \
        -config "$ROFI_CONFIG_FOLDER_LAYOUT"
}

# ============================================================
# Wallpaper picker (within a folder)
# ============================================================

select_wallpaper_in_dir() {
    local dir="$1"

    {
        printf "%s\0display\x1f%s\x1ficon\x1f%s\n" \
            "BACK" \
            "Previous" \
            "go-previous"

        find "$dir" -type f \
            \( "${STATIC_NAME_MATCH[@]}" -o "${ANIMATED_NAME_MATCH[@]}" \) \
            -print0 |
        while IFS= read -r -d '' file; do

            thumb="$(get_cache_path "$file")"

            printf "%s\0display\x1f%s\x1ficon\x1f%s\n" \
                "$file" \
                "$(basename "$file")" \
                "$thumb"

        done
    } | rofi \
        -dmenu \
        -show-icons \
        -p "$(basename "$dir"):" \
        -config "$ROFI_CONFIG_WALLPAPER_LAYOUT"
}

# ============================================================
# Navigation loop
# ============================================================

pick_wallpaper() {
    while true; do
        local folder
        folder="$(select_folder)"
        [[ -z "$folder" ]] && return 1   # ESC Category -> exit

        local chosen
        chosen="$(select_wallpaper_in_dir "$folder")"
        [[ -z "$chosen" ]] && continue        # ESC Wallpapers -> Go back to Categories
        [[ "$chosen" == "BACK" ]] && continue

        echo "$chosen"
        return 0
    done
}

# ============================================================
# Wallpaper application
# ============================================================

stop_animated_wallpaper() {
    pkill -x mpvpaper >/dev/null 2>&1 || true
}

apply_wallpaper() {
    local wall="$1"

    stop_animated_wallpaper

    if is_animated_wallpaper "$wall"; then
        mpvpaper "$MONITOR" -o "no-audio loop" "$wall" &
        disown

        wal \
            -i "$(get_cache_path "$wall")" \
            -n \
            -e \
            -b "$BASE_BACKGROUND_COLOR"
    else
        wal \
            -i "$wall" \
            -n \
            -e \
            -b "$BASE_BACKGROUND_COLOR"

        awww img "$wall" \
            --transition-type center \
            --transition-fps 60 \
            --transition-duration 1.2
    fi
}

# ============================================================
# Spotify / Spicetify
# ============================================================

apply_spicetify() {
    local spotify_running=0
    if pgrep -x spotify >/dev/null 2>&1; then
        spotify_running=1
    fi

    if (( spotify_running )); then
        pkill spotify || true
        while pgrep -x spotify >/dev/null 2>&1; do
            sleep 0.2
        done
        spicetify apply
        spotify >/dev/null 2>&1 &
        disown
    else
        spicetify apply --no-restart
    fi
}

# ============================================================
# Main
# ============================================================

generate_cache

chosen="$(pick_wallpaper)" || exit 0

wall="$chosen"

apply_wallpaper "$wall"

apply_spicetify

~/.config/waybar/scripts/reload.sh >/dev/null 2>&1 &
disown
