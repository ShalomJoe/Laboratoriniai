% Nurodome failo pavadinimą ir kelią, kuriame yra CSV failas su duomenimis.
filename = "C:\Users\arnas\Desktop\test.csv";

% Nuskaitome CSV failą ir nustatome teksto tipą į 'string'.
data = readtable(filename, 'TextType', 'string');

% Ištraukiame teksto duomenis iš stulpelio 'Description'.
textData = data.Description;

% Tokenizuojame tekstą (skaidome į žodžius).
documents = tokenizedDocument(textData);

% Pašaliname stop žodžius (dažniausiai pasitaikančius žodžius, kurie neduoda svarbos).
documents = removeStopWords(documents);

% Pašaliname skyrybos ženklus iš teksto.
documents = erasePunctuation(documents);

% Sukuriame žodžių maišą (bag of words) iš dokumentų.
bag = bagOfWords(documents);

% Nustatome kelių temų skaičių.
numTopics = 7;

% Treniruojame LDA (Latent Dirichlet Allocation) modelį su nustatytais parametrais.
mdl = fitlda(bag, numTopics, 'Verbose', 0);

% Atvaizduojame rezultatus: žodžių debesys kiekvienai temai.
figure
for topicIdx = 1:min(4, numTopics)
    subplot(2, 2, topicIdx)
    wordcloud(mdl, topicIdx);
    title("Tema " + topicIdx)
end
