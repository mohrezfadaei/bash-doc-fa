# راهنمای جامع درباره Environment Variables در Bash

متغیرهای محیطی (Environment Variables) در Bash، متغیرهایی هستند که مقادیر آنها به طور گسترده در سیستم‌عامل و در بین فرآیندها و شل‌های مختلف به اشتراک گذاشته می‌شوند. این متغیرها می‌توانند تنظیمات سیستم، مسیرها، و پارامترهای مهمی را نگه‌دارند که برای اجرای نرم‌افزارها و اسکریپت‌ها لازم هستند.

در این راهنما، نحوه کار با متغیرهای محیطی، ارث‌بری آنها در فرآیندها و شل‌های مختلف، و ترفندها و نکات مفیدی برای استفاده از آنها را بررسی خواهیم کرد.

## تعریف متغیرهای محیطی (Environment Variables)

### 1. تعریف یک متغیر محیطی

برای تعریف یک متغیر محیطی از دستور `export` استفاده می‌شود. این دستور متغیری که تعریف می‌شود را به شل و همه فرآیندهای فرزند آن معرفی می‌کند.

### مثال:

```bash
export MY_VARIABLE="Hello, World"
```

### نکته:

- در اینجا، متغیر `MY_VARIABLE` به تمام فرآیندها و اسکریپت‌هایی که در این شل یا از این شل اجرا می‌شوند، منتقل می‌شود.

### 2. نمایش متغیرهای محیطی

برای نمایش متغیرهای محیطی تعریف شده در شل جاری، می‌توانید از دستور `printenv` یا `env` استفاده کنید:

```bash
printenv
```

یا:

```bash
env
```

برای مشاهده مقدار یک متغیر خاص می‌توانید از `echo` استفاده کنید:

```bash
echo $MY_VARIABLE
```

## ارث‌بری متغیرهای محیطی در فرآیندها

متغیرهای محیطی در Bash از والد به فرزند به ارث می‌رسند. به عبارت دیگر، وقتی یک فرآیند جدید در شل ایجاد می‌شود (مثلاً با اجرای یک اسکریپت یا نرم‌افزار)، متغیرهای محیطی از شل والد به آن فرآیند جدید منتقل می‌شوند.

### مثال:

1. **تعریف یک متغیر محیطی**:

   ```bash
   export MY_VAR="Test Value"
   ```

2. **اجرای یک اسکریپت یا نرم‌افزار**:

   ```bash
   ./myscript.sh
   ```

اگر در `myscript.sh` دستور `echo $MY_VAR` وجود داشته باشد، مقدار `MY_VAR` که در شل والد تنظیم شده بود، در این اسکریپت نیز قابل دسترسی خواهد بود.

### نکته مهم:

- متغیرهای محیطی فقط به فرآیندهای فرزند منتقل می‌شوند. اگر در یک اسکریپت متغیری را تعریف کنید و آن را `export` نکنید، آن متغیر فقط در همان شل (یا فرآیند) موجود خواهد بود و به فرآیندهای فرزند ارث نمی‌رسد.

## ارث‌بری در شل‌های جدید

هنگامی که یک شل جدید از شل فعلی باز می‌کنید، متغیرهای محیطی به شل جدید نیز منتقل می‌شوند. برای مثال، اگر از شل Bash جدیدی از شل فعلی اجرا کنید:

```bash
bash
```

تمام متغیرهای محیطی تعریف‌شده در شل والد، در شل جدید نیز در دسترس خواهند بود. با این حال، متغیرهایی که `export` نشده‌اند، فقط در شل جاری موجود خواهند بود و به شل جدید منتقل نمی‌شوند.

### مثال:

```bash
MY_VAR="Local Value"  # این متغیر فقط در شل فعلی قابل دسترسی است
export MY_ENV_VAR="Exported Value"  # این متغیر به شل‌های جدید ارث می‌رسد
```

در شل جدید:

```bash
echo $MY_ENV_VAR  # این متغیر ارث‌برده شده است
echo $MY_VAR  # این متغیر موجود نیست
```

## استفاده از متغیرهای محیطی در اسکریپت‌ها

در اسکریپت‌ها می‌توانید از متغیرهای محیطی به راحتی استفاده کنید. به سادگی می‌توانید متغیرهای محیطی را تعریف کرده و با `export` آنها را در اسکریپت‌های خود به اشتراک بگذارید.

### مثال ساده:

```bash
#!/bin/bash

echo "User: $USER"
echo "Home Directory: $HOME"
```

### متغیرهای پیش‌فرض Bash

Bash تعدادی از متغیرهای محیطی را به طور پیش‌فرض تنظیم می‌کند که در بسیاری از اسکریپت‌ها و فرآیندها مورد استفاده قرار می‌گیرند. برخی از متغیرهای محیطی پیش‌فرض عبارتند از:

- **`HOME`**: مسیر دایرکتوری خانگی کاربر.
- **`USER`**: نام کاربری جاری.
- **`PATH`**: مسیرهایی که برای جستجوی فایل‌های اجرایی استفاده می‌شود.
- **`SHELL`**: مسیر شل فعلی کاربر.
- **`PWD`**: مسیر دایرکتوری فعلی.

### تغییر متغیرهای محیطی پیش‌فرض:

شما می‌توانید متغیرهای محیطی پیش‌فرض را تغییر دهید. برای مثال، تغییر مسیر `PATH` برای اضافه کردن دایرکتوری‌های جدید به جستجوگر فایل‌های اجرایی:

```bash
export PATH=$PATH:/new/directory/path
```

## متغیرهای محیطی و اسکریپت‌های login

هنگامی که یک شل login باز می‌کنید (برای مثال هنگام لاگین به سیستم یا باز کردن ترمینال در حالت login)، شل فایل‌هایی مانند `.bash_profile`, `.bashrc`, `.profile` را بارگذاری می‌کند. این فایل‌ها معمولاً برای تنظیم متغیرهای محیطی استفاده می‌شوند.

### تنظیم متغیرهای محیطی در `.bashrc`:

```bash
export EDITOR=nano
export PATH=$PATH:/usr/local/bin
```

### تفاوت بین `.bashrc` و `.bash_profile`:

- **`.bash_profile`** معمولاً برای شل‌های login اجرا می‌شود.
- **`.bashrc`** برای هر شل جدید (چه login و چه interactive) اجرا می‌شود.

## ترفندها و نکات

### 1. اضافه کردن دائمی متغیرهای محیطی

برای اضافه کردن متغیرهای محیطی به صورت دائمی، می‌توانید آنها را در فایل‌های تنظیمات شل مانند `.bashrc` یا `.bash_profile` قرار دهید. با این کار، هر بار که شل جدیدی باز می‌شود، این متغیرها به صورت خودکار تنظیم می‌شوند.

### 2. استفاده از متغیرهای محلی و جهانی

متغیرهای محلی (local) فقط در شل فعلی قابل دسترسی هستند و به فرآیندهای فرزند ارث نمی‌رسند، در حالی که متغیرهای محیطی با استفاده از `export` به فرآیندهای فرزند منتقل می‌شوند.

```bash
MY_VAR="local value"  # فقط در این شل
export MY_ENV_VAR="global value"  # به تمام فرآیندهای فرزند ارث می‌رسد
```

### 3. پاک کردن متغیرهای محیطی

برای حذف یک متغیر محیطی، می‌توانید از دستور `unset` استفاده کنید:

```bash
unset MY_ENV_VAR
```

### 4. استفاده از `env` برای اجرای موقت با متغیرهای محیطی

با استفاده از دستور `env` می‌توانید اسکریپت یا برنامه‌ای را با تنظیمات موقت متغیرهای محیطی اجرا کنید، بدون اینکه متغیرهای اصلی سیستم تغییر کنند.

### مثال:

```bash
env MY_TEMP_VAR="Temporary Value" ./myscript.sh
```

در این حالت، `MY_TEMP_VAR` فقط برای `myscript.sh` تعریف شده است و پس از پایان اجرای اسکریپت، از بین می‌رود.

### 5. تغییر `PATH` به صورت موقت

برای تغییر موقت مسیر `PATH` و اجرای یک دستور یا اسکریپت، می‌توانید از متغیرهای محیطی موقت استفاده کنید:

```bash
PATH=/new/path:$PATH ./myscript.sh
```

## جمع‌بندی

متغیرهای محیطی در Bash نقش کلیدی در کنترل و مدیریت اجرای اسکریپت‌ها و برنامه‌ها ایفا می‌کنند. با استفاده از این متغیرها می‌توانیم مقادیر مهمی را در شل و فرآیندهای مختلف به اشتراک بگذاریم و آنها را به طور مؤثری مدیریت کنیم. همچنین، با استفاده از ترفندهای مختلف مانند تنظیم دائمی متغیرها یا استفاده از `env` برای اجرای موقت، می‌توانیم انعطاف‌پذیری بیشتری در اسکریپت‌نویسی و مدیریت محیط کاری خود داشته باشیم.
