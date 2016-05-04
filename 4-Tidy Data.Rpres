<style>
.small-code pre code {
  font-size: 1em;
}
</style>

<style>
.midcenter {
    position: fixed;
    top: 50%;
    left: 50%;
}
</style>


R Grafik Paketleri
========================================================
author: İmran Kocabıyık 
date: 7 Mayıs 2016
autosize: true
transition: fade
width: 1280
height:720
font-family: ubuntu
autosize: true


Düzenli Veri & Dağınık Veri
========================================================
incremental: true
<br>
<br>
> *Happy families are all alike; every unhappy family is unhappy in its own way.*     
**Leo Tolstoy**

<br>

> *Like families, tidy datasets are all alike but every messy dataset is messy in its own way.*  
**Hadley Wickham**

Düzenli Veri Nedir?
========================================================
incremental: true


[**Tidy Data**, Hadley Wickham, *Journal of Statistical Software*](https://www.jstatsoft.org/article/view/v059i10/v59i10.pdf)

- **Her değişken bir sütun**
- **Her gözlem bir satır**
- **Her bir ölçüm bir tablo**

Dağınık Data Örnekleri
========================================================
incremental: true

- Sütün isimlerinin değişken değil, değer olması
- Birden fazla değişkenin tek bir sutünda bulunması
- Değişkenlerin hem satır hem de sütünda bulunması
- Birden fazla ölçümleme çalışmasının tek bir tabloda bulunması
- Tek bir ölçümleme çalışmasının birden fazla tabloda bulunması

Sütun isimlerinin değişken değil, değer olması
========================================================
height: 600
width: 800

<div class="midcenter" style="margin-left:-400px; margin-top:-300px;">
<img src="http://www.michaelchimenti.com/wp-content/uploads/2014/08/Screen-shot-2014-07-31-at-10.59.28-PM.png"></img>
</div>

Dağınık Data Örnek 1: En Yaygın İsimler | TUIK
========================================================
incremental: true
class: small-code

```{r}
maleURL <- "http://tuik.gov.tr/PreIstatistikTablo.do?istab_id=1332"
if(!file.exists("male.xls")){
        download.file(maleURL, destfile = "male.xls") 
}
```
```{r include=TRUE, message=FALSE}
library(readxl)
maleNames <- read_excel("male.xls", sheet = 1, skip = 3)
```

Dağınık Data Örnek 1: En Yaygın İsimler | TUIK
========================================================
incremental: true
class: small-code

```{r}
names(maleNames) <- maleNames[1,]
maleNames <- maleNames[3:285,]
colnames(maleNames)[1] <- "name"
head(maleNames)
```

Dağınık Data Örnek 1: En Yaygın İsimler | TUIK
========================================================
incremental: true
class: small-code

```{r}
dim(maleNames)
library(tidyr)
maleNamesTidy <- gather(maleNames, key = year, value = rank, -name, na.rm = TRUE)
```
```{r}
head(maleNamesTidy)
dim(maleNamesTidy)
```
