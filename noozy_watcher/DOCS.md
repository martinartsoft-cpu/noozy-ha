# Noozy Watcher

**Česky** · [English below](#english)

Noozy Watcher hlídá vaše 3D tiskárny nepřetržitě - i když je PC s Noozy vypnuté. Každý tisk zapíše (i z Bambu Handy,
z cloudu, krátké a zrušené tisky s procentem dokončení) a po zapnutí PC ho předá do Noozy, kde čeká v **Tiskách k odečtu**.
Tisk, který PC vidělo doběhnout samo, PC odečte jako dřív. Watcher sám **nikdy nic neodečítá**.

## Instalace

1. **Nastavení → Aplikace → Obchod s aplikacemi → ⋮ → Repozitáře** - přidejte adresu repozitáře Noozy.
2. Nainstalujte **Noozy Watcher** a spusťte ho. V postranním panelu se objeví **Noozy Watcher**.
3. V Noozy na PC: **Nastavení → Telefon a sync → Přidat Noozy Watcher** → **Zkopírovat odkaz**.
4. Na stránce Noozy Watcher odkaz vložte a klikněte **Spárovat** (odkaz platí 2 minuty).

Watcher si od PC převezme data a nastavení tiskáren - data PC zůstanou beze změny. Noozy na PC i Watcher musí mít
stejnou verzi databáze; jinak se spojení odmítne s hláškou, co aktualizovat.

## Home Assistant: entity a kontrola filamentu

S nainstalovaným **Mosquitto broker** (Nastavení → Aplikace) Watcher sám založí zařízení **Noozy Watcher** s entitami:

- **<tiskárna> <slot>** - kolik gramů zbývá na cívce ve slotu (sklad z PC minus tisky, které čekají na odečet). Atributy:
  výrobce, materiál, barva, ID cívky, „váha odhadem".
- **<tiskárna> - málo filamentu** - zapne se na začátku tisku, na který podle Noozy filament nestačí (gramy ze souboru na
  tiskárně; zatím Bambu a Creality). Počítá i s náhradní cívkou stejného filamentu v AMS a s rezervou z nastavení aplikace.
- **<tiskárna> - tisk** - události `print_finished` (každý zapsaný tisk) a `filament_short`.
- **Tisky k odečtu** - kolik tisků čeká na odečet.

Hotová automatizace (blueprint) **Noozy - málo filamentu před tiskem** pošle upozornění a volitelně tisk pozastaví tlačítkem
pauzy z integrace tiskárny - jen u cívky se zváženým zbytkem. Import: Nastavení → Automatizace → Blueprinty → Importovat
blueprint → adresa souboru `blueprints/automation/noozy/noozy_filament_check.yaml` v tomto repozitáři.

## Co je dobré vědět

- Přístupové kódy tiskáren jsou v datech aplikace bez šifrování (Linux v kontejneru nemá kam klíč schovat). Chrání je
  oprávnění Home Assistantu. Záloha HA data Watcheru obsahuje.
- Stránka Watcheru je dostupná jen přes Home Assistant (ingress), ne přímo z domácí sítě.
- **Zrušit párování** smaže kopii dat z PC i nastavení tiskáren. Tisky, které PC ještě nedostalo, se tím ztratí.
- Bambu A1 / P1 přijme jen několik současných připojení. Watcher se připojuje jen na chvíli (dotaz každých 30 s).

---

## English

Noozy Watcher watches your 3D printers around the clock - even when the PC running Noozy is off. It records every print
(also from Bambu Handy, the cloud, short and cancelled prints with completion percentage) and hands it to Noozy when the PC
is back, where it waits in **Prints to deduct**. The Watcher **never deducts anything** itself.

### Installation

1. **Settings → Apps → App store → ⋮ → Repositories** - add the Noozy repository URL.
2. Install **Noozy Watcher** and start it. **Noozy Watcher** appears in the sidebar.
3. In Noozy on the PC: **Settings → Phone and sync → Add Noozy Watcher** → **Copy link**.
4. Paste the link on the Noozy Watcher page and click **Pair** (the link is valid for 2 minutes).

The Watcher receives the PC data and printer settings - the PC data stays unchanged. Noozy on the PC and the Watcher must
have the same database version; otherwise the connection is refused with a message saying what to update.

### Home Assistant: entities and filament check

With the **Mosquitto broker** installed, the Watcher creates a **Noozy Watcher** device with: remaining grams per printer slot
(PC stock minus prints waiting to be deducted), **<printer> - low filament** (turns on when a print starts that the filament is
not enough for - grams from the file on the printer; Bambu and Creality for now; includes an identical backup spool in the AMS
and the reserve from the app settings), **<printer> - print** events (`print_finished`, `filament_short`) and **Prints to deduct**.
The blueprint **Noozy - low filament before printing** notifies you and can pause the print with the pause button of your printer
integration - only for a weighed spool. Import it from `blueprints/automation/noozy/noozy_filament_check.yaml` in this repository.

### Good to know

- Printer access codes are stored unencrypted in the app data (Linux in a container has nowhere to hide a key). Home
  Assistant permissions protect them. HA backups include the Watcher data.
- The Watcher page is reachable only through Home Assistant (ingress), not directly from your network.
- **Unpair** deletes the copy of PC data and printer settings. Prints the PC has not received yet are lost.
- Bambu A1 / P1 accept only a few simultaneous connections. The Watcher connects only briefly (a query every 30 s).
