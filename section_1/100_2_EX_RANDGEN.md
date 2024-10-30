# برنامه randgen

**هدف:** برنامه‌ی `randgen` یک ابزار command-line است که برای تولید رشته‌های تصادفی (رشته‌های معمولی و base64) به کار می‌رود. این برنامه تنظیمات مختلفی برای کنترل طول رشته و نوع کاراکترهای موجود دارد. از طریق این پروژه، شما با مفاهیم کلیدی Bash scripting مانند توابع، متغیرهای محلی (`local`)، مدیریت ورودی‌ها (`shift`)، و پردازش کاراکترهای تصادفی آشنا خواهید شد.

---

## 1. بررسی ساختار و عملکرد کلی برنامه `randgen`

برنامه `randgen` شامل دو بخش اصلی است:

1. **دستورات و گزینه‌ها**: کاربران می‌توانند از طریق دستورات `string` و `base64`، رشته تصادفی مورد نظر خود را تولید کنند.
2. **توابع تولید رشته**: این برنامه از دو تابع برای تولید رشته‌های تصادفی (`generate_string`) و رشته‌های base64 (`generate_base64`) استفاده می‌کند.

---

## 2. راهنمای دستورات

- **`randgen --help`**: نمایش راهنما و اطلاعات کلی برنامه.
- **`randgen string`**: تولید رشته تصادفی. این دستور همراه با گزینه‌های زیر ارائه می‌شود:
  - `--length|-l [NUMBER]`: مشخص‌کننده طول رشته (پیش‌فرض: 16 کاراکتر).
  - `--no-digits|-nd`: حذف اعداد از رشته تولیدی.
  - `--no-upper|-nu`: حذف حروف بزرگ.
  - `--no-lower|-nl`: حذف حروف کوچک.
  - `--no-symbols|-ns`: حذف نمادها.
- **`randgen base64`**: تولید رشته base64 تصادفی.
  - `--length|-l [NUMBER]`: مشخص‌کننده طول رشته base64 تولید شده.

---

## 3. مفاهیم کلیدی برنامه

### راهنما برای `local`

**`local`** یکی از دستورات داخلی Bash است که برای تعریف متغیرهای محلی در توابع به کار می‌رود. در زبان Bash، اگر متغیری را به صورت محلی تعریف نکنید، آن متغیر به صورت `global` یا سراسری در کل اسکریپت شناخته می‌شود و این موضوع ممکن است باعث ایجاد مشکلات و تداخل‌های ناخواسته در کد شود. با `local`، می‌توانید متغیرهایی بسازید که تنها درون تابعی که تعریف شده‌اند قابل دسترسی باشند.

**مثال برای `local`**:

```bash
function example {
    local var="Local Variable"
    echo "$var"
}
example  # خروجی: Local Variable
echo "$var"  # خروجی خالی، زیرا متغیر local خارج از تابع معتبر نیست
```

**در `randgen`**، از `local` برای تعریف متغیرهای محلی همچون `length`, `charset`, و `result` در تابع `generate_string` استفاده شده است. این کار باعث می‌شود تا این متغیرها در دیگر بخش‌های اسکریپت تداخلی ایجاد نکنند و محدود به محدوده‌ی تابع خود باشند.

### راهنما برای `shift`

**`shift`** یک دستور داخلی Bash است که پارامترهای ورودی به اسکریپت را به سمت چپ جابجا می‌کند، یعنی با هر بار اجرای `shift`، مقدار `$1` حذف می‌شود و `$2` به جای `$1` قرار می‌گیرد و به همین ترتیب. این دستور به مدیریت پارامترهای ورودی کمک می‌کند و برای پردازش گزینه‌های ورودی (Options) در توابع و اسکریپت‌های Bash استفاده می‌شود.

**مثال ساده برای `shift`**:

```bash
echo "First parameter: $1"
shift
echo "After shift, first parameter is now: $1"
```

**در `randgen`**، از `shift` برای مدیریت و حذف پارامترهای پردازش‌شده استفاده می‌شود. برای مثال، وقتی که طول رشته از طریق `--length` مشخص می‌شود، پس از پردازش، با استفاده از `shift 2`، `--length` و مقدار آن از پارامترها حذف شده و پارامترهای بعدی به سمت چپ جابجا می‌شوند.

---

## 4. تحلیل برنامه `randgen`

### تابع `display_help`

این تابع، راهنما و اطلاعات کاملی درباره نحوه‌ی استفاده از برنامه را به کاربران نمایش می‌دهد. به عنوان مثال، کاربر با اجرای `randgen --help` می‌تواند با دستورات و گزینه‌های موجود آشنا شود.

```bash
function display_help() {
    echo "Usage: randgen [command] [options]"
    echo ""
    echo "Commands:"
    echo "  --help                   Show this help message"
    echo "  string                   Generate a random string"
    echo "      --length|-l [NUMBER] Length of the string (default is 16)"
    echo "      --no-digits|-nd      Exclude digits from the string"
    echo "      --no-upper|-nu       Exclude uppercase letters from the string"
    echo "      --no-lower|-nl       Exclude lowercase letters from the string"
    echo "      --no-symbols|-ns     Exclude symbols from the string"
    echo ""
    echo "  base64                   Generate a random base64 string"
    echo "      --length|-l [NUMBER] Length of the base64 string"
}
```

### تابع `generate_string`

این تابع یک رشته تصادفی با کاراکترهای مشخص‌شده تولید می‌کند. در این تابع، کاربر می‌تواند نوع کاراکترهای موجود (اعداد، حروف بزرگ، حروف کوچک، نمادها) را تعیین کند.

```bash
function generate_string() {
    local length=16
    local include_digits=1
    local include_upper=1
    local include_lower=1
    local include_symbols=1

    # پردازش گزینه‌ها
    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            --length|-l)
                length="$2"
                shift 2
                ;;
            --no-digits|-nd)
                include_digits=0
                shift
                ;;
            --no-upper|-nu)
                include_upper=0
                shift
                ;;
            --no-lower|-nl)
                include_lower=0
                shift
                ;;
            --no-symbols|-ns)
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
```

1. **استفاده از `local`**: متغیرهایی مانند `length` و `charset` در سطح محلی تابع تعریف شده‌اند تا تنها درون تابع معتبر باشند.
2. **استفاده از `shift` برای پردازش گزینه‌ها**: هر گزینه پس از پردازش حذف می‌شود تا برنامه بتواند بقیه گزینه‌ها را به راحتی پردازش کند.

### تولید رشته و نمایش خروجی

پس از تنظیم متغیرها، مجموعه‌ای از کاراکترها با توجه به انتخاب‌های کاربر ساخته می‌شود و رشته تصادفی تولید می‌شود.

```bash
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
        result+="${charset:RANDOM % ${#charset}:1}"
    done

    echo "$result"
}
```

در این قسمت، مجموعه کاراکترهای رشته (charset) با توجه به تنظیمات کاربر ایجاد شده و به صورت تصادفی از آن‌ها رشته‌ای با طول مورد نظر تولید می‌شود.

### تابع `generate_base64`

این تابع از دستور `openssl` برای تولید رشته‌های base64 با طول مشخص استفاده می‌کند. رشته base64 برای رمزنگاری یا انتقال امن داده‌ها استفاده می‌شود.

```bash
function generate_base64() {
    local length=16

    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            --length|-l)
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
```

---

## جمع‌بندی: نکات کلیدی

1. **`local`**: برای تعریف متغیرهایی که تنها در سطح تابع معتبر باشند. این ویژگی مانع از تداخل متغیرها می‌شود و باعث می‌شود برنامه‌ای ایمن‌تر داشته باشیم.
2. **`shift`**: با استفاده از `shift` می‌توان پارامترهای پردازش‌شده را حذف کرد تا بقیه پارامترها به سادگی مدیریت شوند. این روش برای پردازش گزینه‌های ورودی، کار را بسیار آسان‌تر می‌کند

. 3. **مجموعه کاراکترها و تولید رشته‌های تصادفی**: این برنامه به کاربران امکان می‌دهد رشته‌های تصادفی را بر اساس نیاز خود تولید کنند و با ترکیب دستوراتی مانند `openssl` و `RANDOM`، رشته‌های ایمن و متنوع ایجاد می‌کند.
