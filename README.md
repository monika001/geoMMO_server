# Jak zacząć?
1. Instalujecie git
2. Ściągacie repozytorium za pomocą: `git clone https://github.com/matDobek/geoMMO.git`

# Jak używać?
* `git remote add origin `https://github.com/matDobek/geoMMO.git -> dodaje skrót, teraz zamiast za każdym razem wpisywać link do repozytorium zdalnego wpisujemy tylko skrót `origin`
* `git pull origin ` -> ściągamy bieżącą wersję repozutorium, która znajduje się na githubie
* Jak zrobicie u siebie na kompie zmiany, które chcecie żeby pojawiły się na githubie ( czyli były dostępne dla wszystkich ):
	1. `git add .` -> informuje git żeby dodał wszystkie zmiany w bieżącym folderze, do swojego lokalnego folderu
	2. `git commit -m "JAKAS_WIADOMOSC"` -> dodanym przed chwilą zmianą nadaje ID i dołącza do nich JAKAS_WIADOMOSC (najlepiej tam wpisać info, co zrobiliście)
	3. `git push origin master` -> wysyłacie na git-a wasze zmiany( wg formatu `git push GDZIE? CO?`- gdzie: na nasze repozytorim na gicie, co: nazwę gałęzi ze zmianami nad którą pracujecie: domyślnie master ) 

# Dobre praktyki
* małe zmiany, ale często wrzucane na githuba
* trzymajmy się nazewnictwa commitów po angielsku
* nie używamy komendy git rebase
