# راهنمای جامع و کامل دستور `sed` در Bash

**`sed`** (Stream Editor) یک ابزار قدرتمند و انعطاف‌پذیر در Bash است که برای ویرایش متون به‌صورت خودکار به کار می‌رود. این دستور به شما امکان می‌دهد تا متون را جستجو، جایگزین، حذف و به‌طور کلی ویرایش کنید. `sed` در بسیاری از زبان‌های برنامه‌نویسی، ابزارهای خط فرمان، و پردازش داده‌ها مورد استفاده قرار می‌گیرد.

## 1. مقدمات دستور `sed`

ساختار پایه دستور `sed` به شکل زیر است:

```bash
sed 'command' filename
```

یا می‌توانید از آن در قالب پایپ (pipe) نیز استفاده کنید:

```bash
echo "text" | sed 'command'
```

### اجرای دستورات `sed`

برای اعمال ویرایش‌های مختلف، `sed` از دستورات متنوعی استفاده می‌کند. برخی از این دستورات شامل `s` برای جایگزینی، `d` برای حذف و `p` برای چاپ هستند.

## 2. دستورات پایه `sed`

### 2.1. جایگزینی متن با `s`

برای جایگزینی یک عبارت یا متن در `sed` از دستور `s` استفاده می‌شود.

#### مثال:

```bash
sed 's/old/new/' filename
```

این دستور اولین وقوع `old` را با `new` جایگزین می‌کند.

#### جایگزینی همه وقوع‌ها با `g`:

```bash
sed 's/old/new/g' filename
```

این دستور تمام وقوع‌های `old` را در هر خط با `new` جایگزین می‌کند.

### 2.2. حذف خط با `d`

دستور `d` برای حذف خطوط به کار می‌رود.

#### مثال:

```bash
sed '2d' filename
```

این دستور خط دوم فایل را حذف می‌کند.

#### حذف محدوده‌ای از خطوط:

```bash
sed '2,4d' filename
```

این دستور خطوط ۲ تا ۴ فایل را حذف می‌کند.

### 2.3. چاپ خط با `p`

دستور `p` برای چاپ خطوط مورد نظر استفاده می‌شود. معمولاً با فلگ `-n` برای جلوگیری از چاپ تمامی خطوط به کار می‌رود.

#### مثال:

```bash
sed -n '2p' filename
```

این دستور فقط خط دوم را چاپ می‌کند.

## 3. استفاده از الگوهای Regular Expression در `sed`

یکی از قابلیت‌های برجسته `sed` استفاده از Regular Expression (الگوهای منظم) است. این ویژگی امکان جستجو و جایگزینی بر اساس الگوهای خاص را فراهم می‌کند.

### مثال‌ها

#### جایگزینی کلمات شروع شونده با `a`:

```bash
sed 's/\ba\w*/word/g' filename
```

این دستور تمام کلماتی که با `a` شروع می‌شوند را با `word` جایگزین می‌کند.

#### جایگزینی خطوطی که با عدد شروع می‌شوند:

```bash
sed '/^[0-9]/s/foo/bar/' filename
```

این دستور فقط خطوطی که با عدد شروع می‌شوند را بررسی و کلمه `foo` را با `bar` جایگزین می‌کند.

## 4. آدرس‌دهی در `sed`

`sed` امکان ویرایش بخش‌های خاصی از فایل را بر اساس آدرس‌دهی دارد.

### 4.1. آدرس‌دهی خطی

شما می‌توانید یک خط خاص یا یک بازه از خطوط را هدف قرار دهید.

#### مثال‌ها

- **خط خاص**:

  ```bash
  sed '5s/foo/bar/' filename
  ```

  این دستور فقط در خط پنجم `foo` را با `bar` جایگزین می‌کند.

- **بازه خطوط**:

  ```bash
  sed '10,20s/foo/bar/' filename
  ```

  این دستور فقط از خط ۱۰ تا ۲۰، `foo` را با `bar` جایگزین می‌کند.

### 4.2. آدرس‌دهی بر اساس الگو

می‌توانید براساس یک الگوی خاص خطوطی را هدف قرار دهید.

#### مثال:

```bash
sed '/^Section/s/foo/bar/' filename
```

این دستور فقط خطوطی که با `Section` شروع می‌شوند را بررسی و `foo` را با `bar` جایگزین می‌کند.

## 5. جایگزینی و ویرایش‌های پیشرفته

### 5.1. استفاده از متغیرهای الگو با `&`

در دستور جایگزینی `s`، می‌توانید از `&` به‌عنوان جایگزینی برای عبارت یافت‌شده استفاده کنید.

#### مثال:

```bash
sed 's/[0-9][0-9]*/[&]/g' filename
```

این دستور همه اعداد را با همان عدد داخل براکت جایگزین می‌کند (مثلاً `123` به `[123]` تبدیل می‌شود).

### 5.2. استفاده از گروه‌بندی‌ها

در `sed`، می‌توانید گروه‌بندی‌های داخل پرانتز را با `\1`, `\2` و ... ارجاع دهید.

#### مثال:

```bash
sed 's/\([0-9]\{3\}\)-\([0-9]\{4\}\)/(\1) \2/' filename
```

این دستور شماره‌های مثل `123-4567` را به `(123) 4567` تبدیل می‌کند.

## 6. فلگ‌های پرکاربرد در `sed`

| فلگ  | توضیحات                                         |
| ---- | ----------------------------------------------- |
| `-n` | عدم چاپ خروجی به طور پیش‌فرض                    |
| `-e` | اجرای چندین دستور در یک خط                      |
| `-i` | ویرایش فایل به صورت درجا (بدون ایجاد فایل موقت) |
| `-r` | استفاده از Regular Expressionهای توسعه‌یافته    |

### مثال استفاده از فلگ‌ها

#### ویرایش فایل به‌صورت درجا

```bash
sed -i 's/foo/bar/g' filename
```

این دستور همه `foo`ها را با `bar` جایگزین می‌کند و تغییرات به‌طور مستقیم در فایل اعمال می‌شود.

## 7. نمونه‌های پیشرفته

### 7.1. اضافه کردن خط پس از یک الگو

برای اضافه کردن خط پس از یک الگوی خاص، از دستور `a\` استفاده کنید.

#### مثال:

```bash
sed '/pattern/a\New line after pattern' filename
```

### 7.2. اضافه کردن خط قبل از یک الگو

برای اضافه کردن خط قبل از الگو، از دستور `i\` استفاده کنید.

#### مثال:

```bash
sed '/pattern/i\New line before pattern' filename
```

### 7.3. جایگزینی چندین الگو با `|`

```bash
sed 's/foo\|bar/baz/g' filename
```

این دستور همه `foo` یا `bar`ها را با `baz` جایگزین می‌کند.

### 7.4. حذف خطوط خالی

برای حذف تمام خطوط خالی از یک فایل، از دستور زیر استفاده کنید:

```bash
sed '/^$/d' filename
```

### 7.5. استفاده از `sed` برای ویرایش چند فایل

برای اعمال دستورات `sed` روی چندین فایل، از ساختار زیر استفاده کنید:

```bash
sed -i 's/foo/bar/g' file1.txt file2.txt
```

## جمع‌بندی

`sed` یک ابزار ویرایش متنی قدرتمند است که به شما اجازه می‌دهد به‌سرعت و به‌سادگی تغییرات گسترده‌ای را در فایل‌ها و متن‌ها اعمال کنید. با استفاده از دستورات، فلگ‌ها و الگوهای مختلف، `sed` به یکی از ابزارهای ضروری برای کار با متن در سیستم‌های یونیکس و لینوکس تبدیل شده است.

### جدول خلاصه دستورات `sed`

| دستور | توضیحات                                               |
| ----- | ----------------------------------------------------- |
| `s`   | جایگزینی یک متن با متن دیگر                           |
| `d`   | حذف یک خط یا بازه‌ای از خطوط                          |
| `p`   | چاپ یک خط یا بازه‌ای از خطوط                          |
| `a\`  | اضافه کردن یک خط پس از یک الگو                        |
| `i\`  | اضافه کردن یک خط قبل از یک الگو                       |
| `-i`  | ویرایش فایل به‌صورت درجا (بدون ایجاد فایل موقت)       |
| `-n`  | جلوگیری از چاپ خودکار و استفاده از `p` برای چاپ خروجی |
| `-r`  | استفاده از Regular Expressionهای توسعه‌یافته          |

با تمرین و استفاده از `sed`، می‌توانید به یکی از ماهرترین کاربران این ابزار مفید و کاربردی تبدیل شوید.