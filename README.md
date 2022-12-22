AUTOMATISER LE DEPLOIEMENT D'UN SERVEUR MQTT

  1. MQTT
  
    a. Définition
  
      Plus connu sous l’acronyme MQTT, le protocole Message Queuing Telemetry Transport est un protocole de messagerie léger
			adapté aux situations où les clients doivent utiliser peu de code et sont connectés à des réseaux
			peu fiables ou limitésen bande passante. Il est principalement utilisé dans la communication
			entre machines (M2M) ou sur les types de connexions propres à l’Internet des Objets.
  
    b. Historique
  
      Créé par Andy Stanford-Clark et Arlen Nipper en 1999, MQTT est un protocole de messagerie qui, à son origine,
			visait à permettre aux capteurs utilisés dans l’industrie pétrolière et gazière d’envoyer leurs données
			à des serveurs distants. Ces appareils de supervision étaient la plupart du temps installés 
			dans des lieux reculés où il était difficile, sinon impossible, d’installer une ligne téléphonique,
			une connexion filaire ou un système de transmission radio. 
			À l’époque, la seule solution pour ces cas de figure était la liaison satellite, une option extrêmement
			onéreuse et facturée à l’aune de la quantité de données consommée. Les acteurs de l’industrie, 
			qui avaient déployé des milliers de capteurs sur le terrain, avaient besoin d’un mode de communication
			capable de transmettre des données avec toute la fiabilité requise, 
			tout en consommant un minimum de bande passante.

   		MQTT a été standardisé en tant que format ouvert par l’Organization 
			for the Advancement of Structured Information Standards (OASIS) en 2013.
			À ce jour, l’OASIS gère encore le standard MQTT.

    c. Architecture

      MQTT est un protocole de messagerie push-subscribe basé sur le protocole TCP/IP. 
			Dans l’architecture MQTT, il existe deux types de systèmes : les clients 
			et les brokers (courtiers). Le broker est le serveur avec lequel les clients communiquent.
			Il reçoit les communications qui émanent des clients et les retransmet à d’autres clients.
			Ainsi, les clients ne communiquent pas directement entre eux, mais toujours par l’intermédiaire du broker. 
			Chaque client peut être soit éditeur, soit abonné, soit les deux.

      MQTT est un protocole orienté événements. Afin de minimiser le nombre de transmissions, 
			les données ne sont envoyées ni à intervalles définis, ni en continu. 
			Un client publie uniquement quand il a des informations à transmettre, 
			et un broker n’envoie des informations aux abonnés que quand il reçoit de nouvelles données.

![image](https://user-images.githubusercontent.com/69314477/209101072-0fd216b6-0573-4c54-9cf1-6270ccb7ed23.png)

    d. Architecture des messages

      MQTT minimise également ses transmissions grâce à un système de messages à la construction allégée et bien cadrée.
			Chaque message se compose d’un en-tête fixe de 2 octets, auquel peut s’ajouter un en-tête facultatif 
			dont l’usage va toutefois alourdir le poids du message. La charge utile des messages est, pour sa part, 
			limitée à 256 Mo.
			Les trois niveaux de qualité de service laissent aux concepteurs de réseau le choix de minimiser le nombre 
			de transmissions de données ou d’en maximiser la fiabilité.

      QoS 0 — c’est le niveau minimal de transmission de données. Quand on choisit ce niveau de QoS, 
			chaque message est envoyé à l’abonné une seule fois, sans accusé de réception. 
			Il est donc impossible de savoir si l’abonné l’a reçu. 
			Dans ce niveau de qualité de service, les messages sont expédiés « au plus une fois ». 
			Comme ce niveau de QoS part du principe que les messages sont systématiquement remis, 
			ces derniers ne sont pas conservés en vue d’un envoi ultérieur aux clients 
			qui seraient déconnectés au moment de leur transmission.
      QoS 1 — le broker tente de remettre le message, puis attend un accusé de réception de la part de l’abonné. 
			Si cet accusé n’est pas reçu dans le délai défini, le message est réexpédié. 
			Avec cette méthode, l’abonné peut recevoir le message plus d’une fois si le broker
			ne reçoit pas de confirmation de réception dans le temps imparti.
			Dans ce niveau de QoS, les messages sont assurés d’arriver « au moins une fois ».
      QoS 2 — le client et le broker utilisent deux paires de paquets pour s’assurer que le message a été remis, 
			et pour vérifier qu’il n’a été reçu qu’une seule fois. Dans ce niveau de QoS, les messages 
			sont assurés d’arriver « exactement une fois ».

      Dans les situations où les communications sont fiables, mais limitées, QoS 0 peut 
			apparaître comme la meilleure option.
			Dans celles où les liaisons ne sont pas fiables, mais où les connexions ne sont pas limitées, 
			QoS 2 semble être un choix tout indiqué. 
			Quant au QoS 1, il réunit pour ainsi dire le meilleur des deux mondes, mais requiert que l’application 
			qui reçoit les données soit capable de gérer des doublons.

      Dans le cas de QoS 1 comme de QoS 2, les messages sont mémorisés ou placés 
			en file d’attente à l’intention des clients qui sont hors ligne et ont établi une session permanente. 
			Ces messages sont réexpédiés (en fonction du niveau de QoS correspondant) 
			dès que le client se sera reconnecté.
			


  2. Création des intances Scaleway
	
  3. Installation de Docker
	
  4. Montage du contenaire Mqtt
			
			

