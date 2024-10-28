# راهنمای جامع درباره آرگومان‌ها، Whitespace‌ها و IFS در Bash

در این مستند، به بررسی آرگومان‌ها (Arguments)، فضاهای خالی (Whitespaces) و متغیر IFS (Internal Field Separator) در Bash می‌پردازیم. این مفاهیم اساسی نقش بسیار مهمی در نحوه پردازش ورودی‌ها، مدیریت فایل‌ها و اسکریپت‌های Bash دارند. در این راهنما با نحوه کار با آرگومان‌ها، مدیریت فضاهای خالی و استفاده از IFS آشنا می‌شوید.

## 1. آرگومان‌ها در Bash

آرگومان‌ها مقادیری هستند که به هنگام اجرای اسکریپت از طریق خط فرمان به آن پاس داده می‌شوند. آرگومان‌ها می‌توانند مقادیر مختلفی از قبیل رشته‌ها، اعداد یا مسیر فایل‌ها باشند.

### دسترسی به آرگومان‌ها

- `$0`: نام اسکریپت را نگه می‌دارد.
- `$1`, `$2`, ..., `$N`: به آرگومان‌های خط فرمان دسترسی دارند.
- `$#`: تعداد آرگومان‌های پاس داده شده به اسکریپت را برمی‌گرداند.
- `$@`: لیستی از تمامی آرگومان‌ها.
- `$*`: مشابه `$@` اما با تفاوت‌های جزیی در مدیریت فضاهای خالی.

### مثال ساده:

```bash
#!/bin/bash
echo "Name of script: $0"
echo "First argument: $1"
echo "Second argument: $2"
echo "Number of arguments: $#"
echo "All arguments: $@"
```

### تفاوت `$@` و `$*`:

- **`$@`**: آرگومان‌ها را به صورت جداگانه و مستقل مدیریت می‌کند و در حلقه‌ها کاربرد بیشتری دارد.
- **`$*`**: همه آرگومان‌ها را به عنوان یک رشته واحد پردازش می‌کند.

### مثال برای تفاوت:

```bash
#!/bin/bash
for arg in "$@"; do
    echo "Arg using \$@: $arg"
done

for arg in "$*"; do
    echo "Arg using \$*: $arg"
done
```

### جدول مقایسه‌ای `$@` و `$*`:

| نوع  | مدیریت آرگومان‌ها                                      | مناسب برای                   |
| ---- | ------------------------------------------------------ | ---------------------------- |
| `$@` | هر آرگومان را به صورت جداگانه پردازش می‌کند            | حلقه‌ها                      |
| `$*` | تمام آرگومان‌ها را به عنوان یک رشته واحد پردازش می‌کند | پردازش به عنوان یک رشته واحد |

## 2. فضاهای خالی (Whitespaces)

در Bash، فضاهای خالی (مانند space, tab, newline) نقش مهمی در جداسازی دستورات و آرگومان‌ها دارند. اگر فضاهای خالی به درستی مدیریت نشوند، ممکن است آرگومان‌ها یا دستورات به اشتباه پردازش شوند.

### مثال مشکل ناشی از Whitespace:

اگر در اسکریپتی بخواهید یک رشته با فضاهای خالی را پردازش کنید و آن را داخل دابل کوتیشن نگذارید، نتیجه ممکن است غیرمنتظره باشد.

```bash
#!/bin/bash
var=Hello World
echo $var  # فقط "Hello" چاپ می‌شود و "World" به عنوان آرگومان دوم محسوب می‌شود.
```

### راه حل:

برای پردازش صحیح فضاهای خالی، باید از دابل کوتیشن استفاده کنید:

```bash
#!/bin/bash
var="Hello World"
echo "$var"  # خروجی صحیح: "Hello World"
```

### نکته: اجتناب از تغییرات ناخواسته در مقادیر

برای جلوگیری از حذف ناخواسته فضاهای خالی، همیشه متغیرها را داخل دابل کوتیشن قرار دهید.

## 3. IFS (Internal Field Separator)

متغیر IFS (جداکننده فیلد داخلی) در Bash تعیین می‌کند که چگونه Bash فیلدها (یا آرگومان‌ها) را در دستورات و ورودی‌ها جدا کند. به طور پیش‌فرض، IFS با فاصله (space)، تب (tab) و خط جدید (newline) تنظیم شده است.

### نمایش مقدار پیش‌فرض IFS:

```bash
echo "$IFS" | cat -A
```

### تغییر مقدار IFS

شما می‌توانید مقدار IFS را تغییر دهید تا از کاراکترهای دیگری برای جداسازی فیلدها استفاده شود. این کار معمولاً هنگام پردازش فایل‌های CSV یا داده‌های جداشده با کاراکترهای خاص مفید است.

### مثال: استفاده از کاما به عنوان IFS

فرض کنید می‌خواهید یک فایل CSV را پردازش کنید که فیلدهای آن با کاما (`,`) جدا شده‌اند. برای این کار، باید مقدار IFS را به کاما تغییر دهید.

```bash
#!/bin/bash
IFS=","
input="apple,banana,cherry"
for fruit in $input; do
    echo "Fruit: $fruit"
done
```

### بازگرداندن مقدار پیش‌فرض IFS:

پس از تغییر مقدار IFS، بهتر است آن را به مقدار پیش‌فرض برگردانید تا از مشکلات احتمالی در سایر بخش‌های اسکریپت جلوگیری شود.

```bash
IFS=$' \t\n'  # مقدار پیش‌فرض IFS
```

### جدول مقایسه کاربردهای IFS:

| نوع کاربرد              | مقدار IFS | توضیحات                                         |
| ----------------------- | --------- | ----------------------------------------------- |
| پیش‌فرض                 | ` \t\n`   | جداکننده فیلدها به صورت فضای خالی، تب و خط جدید |
| پردازش فایل CSV         | `,`       | جداکننده فیلدها با کاما                         |
| جدا کردن با نقطه‌ویرگول | `;`       | برای پردازش ورودی‌های جداشده با نقطه‌ویرگول     |

### ترفندهای کار با IFS

1. **پردازش فایل‌های CSV**: با تغییر مقدار IFS به `,`، می‌توانید فایل‌های CSV را به راحتی پردازش کنید.
2. **مدیریت رشته‌ها**: اگر رشته‌ای دارید که به وسیله کاراکتر خاصی جدا شده است، با تغییر IFS می‌توانید به سادگی آن را پردازش کنید.
3. **بازگرداندن مقدار پیش‌فرض IFS**: پس از تغییر IFS، همیشه مقدار آن را به حالت پیش‌فرض برگردانید تا از مشکلات غیرمنتظره جلوگیری شود.

## جمع‌بندی

- **آرگومان‌ها**: برای دسترسی به آرگومان‌های خط فرمان از `$0`, `$1`, ... و `$@` استفاده کنید. تفاوت‌های ظریفی بین `$@` و `$*` وجود دارد که بسته به نیاز باید از آن‌ها استفاده کنید.
- **Whitespace**: مدیریت صحیح فضاهای خالی با استفاده از دابل کوتیشن‌ها ضروری است تا از جداسازی اشتباه آرگومان‌ها جلوگیری شود.
- **IFS**: تغییر مقدار IFS به شما امکان می‌دهد فیلدها را با کاراکترهای دلخواه جدا کنید. این ویژگی به ویژه برای پردازش فایل‌های CSV و داده‌های پیچیده مفید است.

### جدول خلاصه آرگومان‌ها، Whitespace و IFS:

| مفهوم           | توضیحات                                                        | مثال یا کاربرد                                                                   |
| --------------- | -------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| `$0`            | نام اسکریپت جاری                                               | `echo "Script name: $0"`                                                         |
| `$1`, `$2`, ... | دسترسی به آرگومان‌های خط فرمان                                 | `echo "First argument: $1"`                                                      |
| `$@`            | لیستی از تمام آرگومان‌ها، به صورت مستقل                        | `for arg in "$@"; do echo "$arg"; done`                                          |
| `$*`            | تمام آرگومان‌ها به صورت یک رشته واحد                           | `for arg in "$*"; do echo "$arg"; done`                                          |
| Whitespace      | فضاهای خالی در خط فرمان که آرگومان‌ها را جدا می‌کنند           | `"Hello World"` برای جلوگیری از جداسازی اشتباه باید داخل دابل کوتیشن استفاده شود |
| IFS             | جداکننده داخلی فیلدها (به طور پیش‌فرض فضای خالی، تب و خط جدید) | `IFS=","` برای پردازش فایل‌های CSV با استفاده از کاما                            |

این مستند به شما کمک می‌کند تا با درک بهتر آرگومان‌ها، Whitespace‌ها و IFS در Bash، اسکریپت‌های خود را با دقت بیشتری بنویسید و پردازش‌های پیچیده‌تری را انجام دهید.