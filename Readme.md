# terraform
Questo repository è stato creato per offrire un'infrastruttura con Load Balancer e varie macchine per web services

1)Installare terraform

2) Nella cartella di dove si è clonato il progetto lanciare terraform init per installare l'ultima versione del provider già definito nel file provider.tf.

3) Bisogna modificare i codici degli script di terraform per recuperare dal giusto percorso i files con estensione ".sh" da inviare alle istanze remote. I files da inviare sono presenti nel file rar, quindi vanno estratti e inseriti nel percorso impostato in precedenza negli script di terraform.

4) Lanciare il comando "source env-varss". Le variabili di ambiente piuttosto che essere definite classicamente in delle variabili nel file variables sono state definite in modo tale da legarsi alla sessione della riga di comando che si sta eseguendo. Pertanto per caricare nella sessione i valori corrispondenti alle variabili di ambiente utilizzati da terraform bisogna usare il comando source seguito dal file in cui vi sono le variabili di ambiente, in questo caso env-varss.

5) !!!!! I servizi da deployare sull'infrastruttura  non sono presenti su questo repository. Pertanto per far funzionare tutto bisogna rimuovere dagli script i riferimenti al caricamento dei files dei servizi dalle istanze. !!!!!!

6) Effettuati questi passi si è pronti per creare infrastruttura con terraform plan apply e destroy.
