# شِبانگ (Shebang) چیست؟

**شبانگ** (Shebang) به دنباله کاراکتری `#!` در ابتدای فایل‌های اسکریپت اشاره دارد. این دنباله به سیستم‌عامل می‌گوید که از کدام مفسر برای اجرای اسکریپت استفاده کند. به عبارت دیگر، شبانگ مشخص می‌کند که اسکریپت باید با کدام شل یا برنامه خاص اجرا شود.

برای مثال، در یک اسکریپت بش، خط اول به صورت زیر خواهد بود:

```bash
#!/bin/bash
```

در اینجا:

- `#!` دنباله‌ای است که شبانگ را نشان می‌دهد.
- `/bin/bash` مسیری است به مفسر بش که اسکریپت باید توسط آن اجرا شود.

شبانگ به اسکریپت اجازه می‌دهد که بدون نیاز به صراحتاً اجرای مفسر (مثلاً با تایپ `bash script.sh`) تنها با اجرای مستقیم فایل (مثلاً با `./script.sh`) اجرا شود، به شرطی که فایل مجوز اجرای مناسب داشته باشد.

### اهمیت شبانگ:

1. **سازگاری**: شبانگ مشخص می‌کند که اسکریپت توسط کدام مفسر اجرا شود، که به ویژه در محیط‌های مختلف (مانند سیستم‌های لینوکس و macOS) اهمیت دارد.
2. **انعطاف‌پذیری**: با تغییر مفسر در خط شبانگ، می‌توان اسکریپت‌هایی با زبان‌های مختلف (مانند Python یا Perl) نوشت.

بنابراین، شبانگ یک ویژگی کلیدی در اسکریپت‌نویسی است که باعث می‌شود اسکریپت‌ها به طور خودکار توسط مفسر مناسب اجرا شوند.

## نمونه‌های دیگر از شبانگ (Shebang)

در اسکریپت‌نویسی، شبانگ می‌تواند به مفسرهای مختلف اشاره کند، بسته به اینکه از کدام زبان برنامه‌نویسی یا ابزار استفاده می‌کنید. در زیر چند نمونه متداول از شبانگ آورده شده است:

### 1. بش (Bash)

```bash
#!/bin/bash
```

این خط اسکریپت را با استفاده از مفسر Bash اجرا می‌کند که معمولاً در مسیر `/bin/bash` قرار دارد.

### 2. شل (Sh)

```bash
#!/bin/sh
```

این خط اسکریپت را با استفاده از مفسر sh (Bourne Shell) اجرا می‌کند که یک شل قدیمی‌تر و ساده‌تر است. این شبانگ معمولاً در اسکریپت‌های بسیار سازگار با سیستم‌های مختلف استفاده می‌شود.

### 3. پایتون (Python)

```bash
#!/usr/bin/env python3
```

این شبانگ مفسر Python 3 را از مسیر `env` پیدا کرده و اسکریپت را اجرا می‌کند. استفاده از `env` به جای مسیر دقیق مفسر (مانند `/usr/bin/python3`) انعطاف‌پذیری بیشتری دارد و به سیستم اجازه می‌دهد که مفسر پایتون را از مسیرهای مختلف پیدا کند.

### 4. پرل (Perl)

```bash
#!/usr/bin/perl
```

این شبانگ برای اجرای اسکریپت‌های نوشته شده با Perl استفاده می‌شود.

### 5. نود (Node.js)

```bash
#!/usr/bin/env node
```

این شبانگ اسکریپت‌های نوشته شده با Node.js را اجرا می‌کند. همانند پایتون، استفاده از `env` به سیستم اجازه می‌دهد تا مسیر مفسر را به صورت خودکار پیدا کند.

### 6. روبی (Ruby)

```bash
#!/usr/bin/env ruby
```

این شبانگ برای اجرای اسکریپت‌های Ruby استفاده می‌شود.

### 7. زبان سی‌شارپ (C#) با استفاده از Mono

```bash
#!/usr/bin/env mono
```

این شبانگ برای اجرای برنامه‌های نوشته شده با زبان سی‌شارپ در سیستم‌های لینوکس و مک با استفاده از مفسر Mono به کار می‌رود.

### 8. تِش (Tcsh)

```bash
#!/bin/tcsh
```

این شبانگ برای اجرای اسکریپت‌هایی که در محیط tcsh (C shell) نوشته شده‌اند استفاده می‌شود.

### 9. AWK

```bash
#!/usr/bin/awk -f
```

این شبانگ برای اجرای اسکریپت‌های AWK استفاده می‌شود. گزینه `-f` نشان می‌دهد که اسکریپت AWK از یک فایل خوانده شود.

### 10. زبان R

```bash
#!/usr/bin/env Rscript
```

این شبانگ برای اجرای اسکریپت‌های نوشته شده با زبان R استفاده می‌شود.

---

### نتیجه‌گیری:

شبانگ‌ها به کاربر این امکان را می‌دهند که با استفاده از یک خط ابتدایی مشخص کنند کدام مفسر باید اسکریپت را اجرا کند. این قابلیت در اسکریپت‌نویسی باعث سادگی و انعطاف‌پذیری بیشتر در اجرای کدها می‌شود.