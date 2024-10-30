# راهنمای `awk` در Bash

**`awk`** یک ابزار قدرتمند برای پردازش و ویرایش داده‌ها و متن در سیستم‌عامل‌های یونیکس و لینوکس است. با استفاده از `awk`، می‌توانید فایل‌های متنی را خط به خط پردازش کنید و بر اساس الگوها و شرایط خاص، داده‌ها را استخراج، ویرایش، و محاسبه کنید. این دستور در اسکریپت‌نویسی و کار با داده‌ها به‌ویژه در فایل‌های ساختار یافته مانند فایل‌های CSV یا فایل‌های گزارش (logs) کاربرد بسیاری دارد.

## 1. مقدمات دستور `awk`

ساختار پایه دستور `awk` به شکل زیر است:

```bash
awk 'pattern { action }' filename
```

- **`pattern`**: شرطی که مشخص می‌کند کدام خطوط پردازش شوند.
- **`action`**: عملیاتی که روی خطوط مورد نظر انجام می‌شود.

مثال ساده:

```bash
awk '{ print $1 }' filename
```

این دستور ستون اول هر خط از فایل `filename` را چاپ می‌کند.

## 2. اجزای اصلی دستور `awk`

### 2.1. فیلدها و ستون‌ها

`awk` به‌صورت پیش‌فرض داده‌ها را به فیلدهای جدا از هم تقسیم می‌کند. هر فیلد با `$` و شماره فیلد قابل دسترسی است.

- **`$1`**: ستون اول
- **`$2`**: ستون دوم
- **`$0`**: کل خط

#### مثال:

```bash
awk '{ print $1, $3 }' filename
```

این دستور ستون اول و سوم هر خط را چاپ می‌کند.

### 2.2. جداکننده‌ها (FS و OFS)

- **FS** (Field Separator): جداکننده فیلدها؛ به‌صورت پیش‌فرض فاصله است.
- **OFS** (Output Field Separator): جداکننده‌ای که برای خروجی فیلدها استفاده می‌شود.

#### تغییر جداکننده فیلدها

```bash
awk 'BEGIN { FS=","; OFS=" - " } { print $1, $2 }' filename
```

در این مثال، جداکننده ورودی کاما و جداکننده خروجی خط تیره است.

## 3. الگوهای `awk`

الگوهای `awk` امکان پردازش خطوط خاصی از فایل را فراهم می‌کنند. برخی از الگوهای پرکاربرد شامل مقایسه عددی، عبارات منظم (Regular Expressions)، و عملگرهای منطقی هستند.

### 3.1. تطبیق با شرط

```bash
awk '$3 > 50 { print $1, $3 }' filename
```

این دستور فقط خطوطی که مقدار ستون سوم آن‌ها بزرگتر از ۵۰ باشد را چاپ می‌کند.

### 3.2. تطبیق با Regular Expression

```bash
awk '/^ERROR/ { print $0 }' logfile.txt
```

این دستور فقط خطوطی که با `ERROR` شروع می‌شوند را چاپ می‌کند.

### 3.3. عملگرهای منطقی

| عملگر  | توضیحات    |
| ------ | ---------- |
| `&&`   | و (AND)    |
| `\|\|` | یا (OR)    |
| `!`    | نقیض (NOT) |

#### مثال:

```bash
awk '$3 > 50 && $2 == "PASS" { print $1 }' filename
```

این دستور خطوطی را چاپ می‌کند که مقدار ستون سوم آن‌ها بیشتر از ۵۰ و مقدار ستون دوم آن‌ها برابر با `PASS` باشد.

## 4. متغیرها و عملگرها در `awk`

### 4.1. متغیرهای پیش‌فرض `awk`

| متغیر | توضیحات                |
| ----- | ---------------------- |
| `NR`  | شماره خط در کل فایل    |
| `NF`  | تعداد فیلدهای خط جاری  |
| `FS`  | جداکننده فیلدهای ورودی |
| `OFS` | جداکننده فیلدهای خروجی |
| `RS`  | جداکننده خطوط ورودی    |
| `ORS` | جداکننده خطوط خروجی    |

#### مثال استفاده از `NR` و `NF`

```bash
awk '{ print NR, NF, $0 }' filename
```

این دستور شماره خط، تعداد فیلدها و محتوای خط جاری را چاپ می‌کند.

### 4.2. تعریف متغیرهای سفارشی

در `awk` می‌توانید متغیرهای سفارشی تعریف کنید.

#### مثال:

```bash
awk '{ total = $2 + $3; print total }' filename
```

این دستور مجموع ستون‌های دوم و سوم را در متغیر `total` ذخیره و چاپ می‌کند.

## 5. دستورات کنترل جریان در `awk`

### 5.1. شرط `if`

ساختار `if` در `awk` مشابه زبان‌های برنامه‌نویسی دیگر است.

#### مثال:

```bash
awk '{ if ($3 > 50) print $1, $3 }' filename
```

این دستور فقط خطوطی را چاپ می‌کند که مقدار ستون سوم آن‌ها بیشتر از ۵۰ باشد.

### 5.2. حلقه `for`

حلقه `for` در `awk` برای تکرار و پیمایش فیلدها و مقادیر به‌کار می‌رود.

#### مثال:

```bash
awk '{ for (i=1; i<=NF; i++) print $i }' filename
```

این دستور تمامی فیلدهای هر خط را یکی‌یکی چاپ می‌کند.

### 5.3. دستورات `break` و `continue`

این دستورات برای کنترل دقیق‌تر اجرای حلقه‌ها و شرایط به‌کار می‌روند.

#### مثال:

```bash
awk '{ for (i=1; i<=NF; i++) { if ($i == "STOP") break; print $i } }' filename
```

این دستور فیلدها را چاپ می‌کند تا زمانی که به مقدار `STOP` برسد.

## 6. پردازش و عملیات ریاضی در `awk`

`awk` قابلیت انجام عملیات ریاضی را دارد و می‌توان محاسباتی مانند جمع، تفریق، ضرب و تقسیم را با آن انجام داد.

#### مثال:

```bash
awk '{ total = $2 + $3; average = total / 2; print "Average:", average }' filename
```

این دستور میانگین ستون دوم و سوم را محاسبه و چاپ می‌کند.

## 7. بلوک‌های `BEGIN` و `END`

بلوک‌های `BEGIN` و `END` به شما امکان می‌دهند که کدهایی را قبل از شروع و بعد از اتمام پردازش اجرا کنید.

### 7.1. بلوک `BEGIN`

دستوراتی که باید قبل از پردازش خطوط اجرا شوند، در بلوک `BEGIN` قرار می‌گیرند.

#### مثال:

```bash
awk 'BEGIN { print "Processing starts" } { print $0 }' filename
```

### 7.2. بلوک `END`

دستوراتی که باید پس از پردازش تمامی خطوط اجرا شوند، در بلوک `END` قرار می‌گیرند.

#### مثال:

```bash
awk '{ total += $3 } END { print "Total:", total }' filename
```

این دستور جمع تمامی مقادیر ستون سوم را محاسبه و در انتها چاپ می‌کند.

## 8. استفاده از فایل‌های ورودی چندگانه

می‌توانید چند فایل را همزمان با `awk` پردازش کنید.

```bash
awk '{ print FILENAME, $0 }' file1.txt file2.txt
```

این دستور نام فایل و محتوای هر خط را چاپ می‌کند.

## 9. استفاده از توابع در `awk`

`awk` توابع متعددی برای پردازش رشته‌ها و اعداد دارد.

### 9.1. توابع رشته‌ای

| تابع      | توضیحات                                          |
| --------- | ------------------------------------------------ |
| `length`  | طول یک رشته یا فیلد                              |
| `substr`  | استخراج زیررشته                                  |
| `index`   | پیدا کردن موقعیت اولین وقوع یک رشته در رشته دیگر |
| `tolower` | تبدیل رشته به حروف کوچک                          |
| `toupper` | تبدیل رشته به حروف بزرگ                          |

#### مثال:

```bash
awk '{ print toupper($1) }' filename
```

### 9.2. توابع عددی

| تابع    | توضیحات                       |
| ------- | ----------------------------- |
| `int`   | تبدیل عدد به عدد صحیح         |
| `sqrt`  | جذر عدد                       |
| `rand`  | تولید عدد تصادفی بین 0 و 1    |
| `srand` | مقداردهی اولیه به تابع `rand` |

#### مثال:

```bash
awk 'BEGIN { srand(); print int(rand()*100) }'
```

این دستور یک عدد تصادفی بین 0 و 100 تولید می‌کند.