#!/bin/bash

# نمایش راهنما
function display_help() {
    echo "Usage: randgen [command] [options]"
    echo ""
    echo "Commands:"
    echo "  help                   Show this help message"
    echo "  string                   Generate a random string"
    echo "      --length, -l [NUMBER] Length of the string (default is 16)"
    echo "      --no-digits, -nd      Exclude digits from the string"
    echo "      --no-upper, -nu       Exclude uppercase letters from the string"
    echo "      --no-lower, -nl       Exclude lowercase letters from the string"
    echo "      --no-symbols, -ns     Exclude symbols from the string"
    echo
    echo "  base64                   Generate a random base64 string"
    echo "      --length, -l [NUMBER] Length of the base64 string"
}

# تولید رشته‌ی تصادفی
function generate_string() {
    local length=16
    local include_digits=1
    local include_upper=1
    local include_lower=1
    local include_symbols=1

    while [[ "$#" -gt 0 ]]; do
        case "$1" in
        --length | -l)
            length="$2"
            shift 2
            ;;
        --no-digits | -nd)
            include_digits=0
            shift
            ;;
        --no-upper | -nu)
            include_upper=0
            shift
            ;;
        --no-lower | -nl)
            include_lower=0
            shift
            ;;
        --no-symbols | -ns)
            include_symbols=0
            shift
            ;;
        *)
            echo "Invalid option: $1"
            display_help
            exit 1
            ;;
        esac
    done

    local charset=""
    [[ "$include_digits" -eq 1 ]] && charset+="0123456789"
    [[ "$include_upper" -eq 1 ]] && charset+="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    [[ "$include_lower" -eq 1 ]] && charset+="abcdefghijklmnopqrstuvwxyz"
    [[ "$include_symbols" -eq 1 ]] && charset+="!@#$%^&*()-_=+[]{}|;:,.<>/?"

    if [[ -z "$charset" ]]; then
        echo "Error: No character sets selected for generation."
        exit 1
    fi

    local result=""
    for ((i = 0; i < length; i++)); do
        result+="${charset:RANDOM%${#charset}:1}"
    done

    echo "$result"
}

# تولید رشته‌ی base64 تصادفی
function generate_base64() {
    local length=16

    while [[ "$#" -gt 0 ]]; do
        case "$1" in
        --length | -l)
            length="$2"
            shift 2
            ;;
        *)
            echo "Invalid option: $1"
            display_help
            exit 1
            ;;
        esac
    done

    openssl rand -base64 "$((length * 3 / 4))" | head -c "$length"
}

# بررسی ورودی‌های برنامه
if [[ "$#" -eq 0 ]]; then
    display_help
    exit 0
fi

case "$1" in
help)
    display_help
    ;;
string)
    shift
    generate_string "$@"
    ;;
base64)
    shift
    generate_base64 "$@"
    ;;
*)
    echo "Unknown command: $1"
    display_help
    exit 1
    ;;
esac
