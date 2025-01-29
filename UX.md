## Udźwiękowienie

Ubytek słuchu naturalnie postępuje wraz z wiekiem. Na wykresie z portalu Audiofon.pl przedstawiającym ubytki u kobiet na przestrzeli lat widzimy, że dotyczy on głównie wysokich częstotliwości. U mężczyzn te zmiany są statystycznie jeszcze głębsze. Dlatego dobierając dźwięki warto wziąć to pod uwagę.

<img width="250" alt="krzywa-glosnosci" src="https://github.com/user-attachments/assets/3147c4d8-b013-4e09-a617-f9371b02b096">

Kolejnym czynnikiem, którym należy się sugerować tworząc udźwiękowienie aplikacji jest wrażeniowe poczucie głośności w zależności od wysokości tonalnej sygnałów dźwiękowych. Na krzywych akustycznych prezentowanych na stronie internetowej Centralnego Instytutu Ochrony Pracy możemy dostrzec różnicę w słyszalności niskich tonów i wysokich.

Niskie dźwięki powinny być odtwarzane głośniej, aby były tak samo słyszalne jak wyższe. W naszej aplikacji używamy niskiego tonu (niecałe 200Hz) do nawigowania do wybranego ciała astralnego. Wraz ze zmniejszającą się odległością częstotliwość jest zwiększana, a co za tym idzie wrażenie głośności się zwiększa. Nadal jednak jest to stosunkowo niski dźwięk, aby osoby z uszkodzeniami słuchu miały szanse je usłyszeć.

<img width="250" alt="ubytek-sluchu" src="https://github.com/user-attachments/assets/0f976d1c-27a1-4ea7-a652-ee0d85d87dd7">

Lektorzy wybrani do czytania informacji o kosmosie z pakietu ElevenLabs mają niski głos z tych samych względów.

## Haptyka

Projektując inkluzywną aplikację dla jak największego grona odbiorców ważne jest komunikowanie dla możliwie wielu zmysłów. Silnik haptyczny telefonów serii iPhone, na które dedykowana jest nasza aplikacja, pozwala na odtwarzanie zróżnicowanych wzorów haptycznych, opisanych w następnych punktach.

Nawigowanie do wybranego ciała niebieskiego, poza komunikacją dźwiękową opisaną w punkcie powyżej, jest wzbogacona o haptykę, która pomoże osobom z poważnymi uszkodzeniami słuchu i wzroku używać tej funkcjonalności.


## Nawigacja

Aplikacja składa się z 4 podstawowych ekranów, w których haptyka, dźwięk oraz interfejs użytkownika nieco się różnią, choć nadal pozostają spójne. Wspólnymi elementami dla wszystkich trybów jest pasek dolny umożliwiający ich zmianę, oraz górne pole tekstowe zawierające informacje o aktualnym obiekcie na niebie. Wszystkie elementy są częścią biblioteki iOS, dzięki czemu możliwa jest pełna integracja z systemem Voice Over.


1. Tryb oglądania gwiazd

W tym trybie użytkownik skupia się na poznawaniu gwiazd, ich położeniu na niebie oraz w obszarze wokół konstelacji. Na głównym polu wyświetlana jest sfera niebieska oraz centralnie umiejscowiony krzyż celowniczy. Urządzenie wykorzystuje lokalizację oraz żyroskop, by śledzić ruch urządzenia po sferze niebieskiej. Oprócz gwiazd, wyświetlane są linie dzielące niebo na obszary wokół gwiazdozbiorów, po których przekroczeniu zwracany jest krótki sygnał haptyczny i odczytywany jest komunikat z nazwą gwiazdozbioru, na który użytkownik wycelował. Jest odczytywany innym głosem niż pozostałe komunikaty w aplikacji, w celu jasnego rozróżnienia, że chodzi o obszar a nie konkretne ciało niebieskie.

Po skierowaniu urządzenia na gwiazdęm zwracany sygnał haptyczny zależny, który rośnie wraz ze zbliżaniem się do gwiazdy, i którego szczytowa intensywność jest zależna od jasności gwiazdy. Gdy użytkownik wyceluje w gwiazdę, odczytywana jest jej nazwa

Podwójne tapnięcie w ekran powoduje odczytanie większej ilości informacji w trybie czatu głosowego. Możliwe jest zadanie większej ilości pytań.

W górnym polu tekstowym wyświetlane są: nazwa ciała niebieskiego, typ (gwiada/planeta...) oraz obszar wokół konstelacji, w którym znajduje się obiekt.

Z prawej strony ekranu znajduje się suwak progu czułości, określający liczbę wyświetlanych gwiazd - w zależności od ich jasności na niebie. Przy maksymalnej czułości wyświetlane
są wszystkie gwiazdy, przy minimalnej - tylko te najjaśniejsze, tworzące gwiazdozbiory. Element pochodzi z biblioteki iOS, dzięki czemu jest kompatybilny z Voice Over.

Na dole sfery niebieskiej wyświetlany jest półprzezroczysty obszar pod horyzontem. Po wycelowaniu poniżej horyzontu, zwracany jest jednolity sygnał haptyczny o niskiej intensywności, oraz komunikat głosowy. Horyzont pozostaje domyślnie włączony, można go wyłączyć z poziomu ustawień.


2. Tryb oglądania gwiazdozbiorów

W tym trybie użytkownik skupia się na poznawaniu gwiazdozbiorów. Główne pole jest podobne do tego z trybu oglądania gwiazd, ale wyświetlane są tylko te gwiazdy, które tworzą gwiazdozbiory. Dodatkowo gwiazdy są połączone jasnymi liniami. Nie występuje suwak progu czułości. Po skierowaniu urządzenia na gwiazdozbiór, zwracany jest jednostajny sygnał haptyczny o intensywności 40%, do momentu gdy użytkownik pozostaje w polu pomiędzy gwiazdami tworzącymi konstelację. Odczytywany jest komunikat z nazwą gwiazdozbioru.

Podwójne tapnięcie w ekran powoduje odczytanie większej ilości informacji w trybie czatu głosowego. Możliwe jest zadanie większej ilości pytań.

Zwracany jest także sygnał haptyczny po wycelowaniu w gwiazdę, jednak jest on jednolicie intensywny - bez rozróżniania jasności gwiazdy, oraz posiada mniejszą tolerancję odległości niż w przypadku trybu oglądania gwiazd.

W górnym polu tekstowym wyświetlane są polska oraz łacińska nazwa gwiazdozbioru.

Występuje również horyzont - analogicznie jak w trybie oglądania gwiazd, również możliwy do wyłączenia w ustawieniach.


3. Tryb szukania

Po wejściu w tryb szukania górne pole tekstowe staje się edytowalne i jest wyświetlana klawiatura. W przypadku skonfigurowanego Voice Over, może to być od razu głosowe wprowadzanie tekstu. W miarę wprowadzania nazwy szukanego obiektu, wyświetlane są podpowiedzi - zarówno gwiazdy jak i gwiazdozbiory. Użytkownik musi zatwierdzić jedną z podpowiedzi

Po wybraniu obiektu, w zależności od bliskości do obiektu (0% to obiekt po drugiej stronie sfery niebieskiej - średnica) generowany jest dźwięk od 220 do 1200 hZ. Są to częstotliwości słyszalne nawet przez osoby z ubytkiem słuchu, dodatkowo nie są "drażniące". Podobny system jest używany np. przez niewidomych strzelców sportowych podczas celowania do tarczy. 
Oprócz dźwięku, wyświetlany jest wskaźnik w postaci strzałki, aż do momentu pojawienia się obiektu w zasięgu pola widzenia.

W przypadku szukania gwiazdy, występują linie konstelacji wraz z odpowiadającą im haptyką i sygnałami dźwiękowymi, a także haptyka gwiazd.

W przypadku szukania gwiazdozbiorów, występuje haptyka z trybu oglądania gwiazdozbiorów oraz odpowiadające komunikaty głosowe.

Po odnalezieniu obiektu, zwracany jest komunikat głosowy oraz haptyczny, a aplikacja przechodzi w tryb oglądania gwiazd lub konstelacji - w zależności od tego, jaki obiekt był szukany.


4. Tryb ustawień

Po wejściu do trybu ustawień, pole robocze ze sferą niebieską znika, i użytkownik ma do wyboru zmianę następujących parametrów: sygnały haptyczne (0/1), sygnał głosowe (0/1), wielkość wyświetlanych gwiazd (suwak), pokaż horyzont (0/1), asystent AI (0/1). Wszystkie elementy są częścią biblioteki iOS, co pozwala na pełną integrację z Voice Over.

Oprócz ustawień, na dole cały czas wyświetlany jest pasek wyboru trybu, oraz przycisk "Powrót" w lewym górnym rogu, co pozwala na intuicyjne wyjście z ustawień, na dwa sposoby.












