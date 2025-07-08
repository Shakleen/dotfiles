#!/bin/bash

# Path to the state file
STATE_FILE="$HOME/.config/hypr/state/hyprsunset_temperature.txt"

# Define temperature steps (in Kelvin). Ordered from least warm (off/daylight) to most warm.
# You can customize these values.
declare -a TEMP_STEPS=(6500 5500 4500 3500 2800 2500 2200 1900 1800) # 6500K is "off" for our purpose

# Default temperature to apply when turning on (index from TEMP_STEPS array)
# For example, 2500K is at index 5 (0-indexed array)
DEFAULT_TEMP_INDEX=5 

# Ensure the state file exists and has a default value if not
# We'll store the actual temperature value, not the index
if [ ! -f "$STATE_FILE" ]; then
    echo "${TEMP_STEPS[0]}" > "$STATE_FILE" # Start at 6500K (effectively off)
fi

# Function to get current temperature from state file
get_temperature_state() {
    if [ -f "$STATE_FILE" ]; then
        current_val=$(cat "$STATE_FILE")
        # Ensure it's a number, default to 6500 if not
        if echo "$current_val" | grep -Eq '^[0-9]+$'; then
            echo "$current_val"
        else
            echo "${TEMP_STEPS[0]}" # Default to coldest if state file is corrupt
        fi
    else
        echo "${TEMP_STEPS[0]}" # Default to coldest if state file is missing
    fi
}

# Function to set temperature and update state
set_temperature_hyprsunset() {
    local new_temp="$1"

    # Clamp new_temp to the defined steps, and ensure it's a valid number
    if ! echo "$new_temp" | grep -Eq '^[0-9]+$'; then
        new_temp="${TEMP_STEPS[0]}" # Default to coldest if invalid input
    fi

    local matched_step=0 # Flag to check if the new_temp matches any of our steps
    for step in "${TEMP_STEPS[@]}"; do
        if (( new_temp == step )); then
            matched_step=1
            break
        fi
    done

    # If the new_temp isn't one of our defined steps, snap it to the nearest
    # This logic assumes TEMP_STEPS is sorted.
    if (( matched_step == 0 )); then
        local closest_temp=${TEMP_STEPS[0]}
        local min_diff=$(( new_temp > closest_temp ? new_temp - closest_temp : closest_temp - new_temp ))

        for step in "${TEMP_STEPS[@]}"; do
            local diff=$(( new_temp > step ? new_temp - step : step - new_temp ))
            if (( diff < min_diff )); then
                min_diff=$diff
                closest_temp=$step
            fi
        done
        new_temp="$closest_temp"
    fi

    echo "$new_temp" > "$STATE_FILE" # Update state file

    local display_text=""
    if (( new_temp == ${TEMP_STEPS[0]} )); then # If it's the coldest step (6500K)
        hyprctl hyprsunset identity # Treat as "off"
        display_text="Blue Light: OFF"
    else
        hyprctl hyprsunset temperature "$new_temp"
        display_text="Blue Light: ${new_temp}K"
    fi
    swayosd-client --custom-message "$display_text" --custom-icon "temperature-warm-symbolic"
}

# Function to toggle hyprsunset
toggle_hyprsunset() {
    local current_temp=$(get_temperature_state)

    if (( current_temp == ${TEMP_STEPS[0]} )); then # If currently "off" (coldest temp)
        set_temperature_hyprsunset "${TEMP_STEPS[$DEFAULT_TEMP_INDEX]}" # Turn on with default
    else
        set_temperature_hyprsunset "${TEMP_STEPS[0]}" # Turn off (set to coldest)
    fi
}

# Main logic based on arguments
case "$1" in
    "toggle")
        toggle_hyprsunset
        ;;
    "increase")
        current_temp=$(get_temperature_state)
        current_index=-1
        for i in "${!TEMP_STEPS[@]}"; do
            if (( TEMP_STEPS[i] == current_temp )); then
                current_index=$i
                break
            fi
        done

        if (( current_index == -1 || current_index == 0 )); then # If not found or at coldest, start at default
            new_index="$DEFAULT_TEMP_INDEX"
        elif (( current_index < ${#TEMP_STEPS[@]} - 1 )); then # Not at warmest yet
            new_index=$((current_index + 1))
        else # Already at warmest, stay there
            new_index="$current_index"
        fi
        set_temperature_hyprsunset "${TEMP_STEPS[$new_index]}"
        ;;
    "decrease")
        current_temp=$(get_temperature_state)
        current_index=-1
        for i in "${!TEMP_STEPS[@]}"; do
            if (( TEMP_STEPS[i] == current_temp )); then
                current_index=$i
                break
            fi
        done

        if (( current_index == -1 || current_index == ${#TEMP_STEPS[@]} - 1 )); then # If not found or at warmest, start at default
            new_index="$DEFAULT_TEMP_INDEX"
        elif (( current_index > 0 )); then # Not at coldest yet
            new_index=$((current_index - 1))
        else # Already at coldest, stay there
            new_index="$current_index"
        fi
        set_temperature_hyprsunset "${TEMP_STEPS[$new_index]}"
        ;;
    "get_strength") # Renamed for consistency, but still shows temperature
        temp=$(get_temperature_state)
        text=""
        if (( temp == ${TEMP_STEPS[0]} )); then # If at the coldest step, consider it "OFF"
            text="OFF"
        else
            text="${temp}K"
        fi
        # Output JSON for Waybar
        echo "{\"text\": \"$text\"}"
        ;;
    *)
        echo "Usage: $0 {toggle|increase|decrease|get_strength}" >&2
        exit 1
        ;;
esac
