# AUTOMATISER LE DEPLOIEMENT D'UN SERVEUR MQTT

  

## 1. MQTT

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

  ---
## 2. Fichiers 

*deploy_emqx*
> Script pour récupérer les fichiers sur githun d'installation de docker et de montage de l'image du container emqx sur l'instance puis de les éxecuter 

*emqx-manager*  
> Script pour interface graphique de la création d'instance automatisé

*go*  
> Script de connexion en ssh au instance 

*install-docker*
> Script regroupant les actions pour installer docker sur l'instance

*install-emqx*
> Script regroupant les actions pour démarrer le container EMQX sur l'instance

*instances_deployed*  
> Fichier regroupant la liste des ip des  instances déployés 

*instance_ips*
> Fichier regroupant la liste des ips créer via l'interface grapgique

*instances.tf*  
> Script terraform pour créer un nombre d'instance selon le nombre donné par l'utilisateur en début d'éxecution

*teamname.txt* 
> Fichier contenant le nom de groupe des instances créer

---
## 3. Processus de création d'instance

Afin de simplifier la création d'instance, nous avons opter pour l'utilisation de boite dialogue avec des choix et des inputs. 

Pour commencer il faut pull la branche finale du git ``git clone --branch final https://github.com/Redart71/dailyBear.git``.

Puis aller dans le dossier dailyBear ``cd dailyBear``

Pour lancer l'interface grapgique il faur éxecuter le fichier ``./emqx-manager`` .

Lors du lancement de celui-ci , la première boite de dialogue demande à l'utilisateur de renter le nom qui va être utiliser pour créer les instances. 

![Pasted image 20230113194505](https://user-images.githubusercontent.com/92815115/212397470-45baeef5-82f5-474d-84c4-af741724b301.png)

De cette facon en relance l'interface, on peut décider de changer de nom et donc de créer un autre groupe d'instance avec un autre nom.

Après avoir choisi le nom du groupe d'instance, l'utilisateur arrivera sur le menu ci-dessous.

Lors de sa première utilisation, il n'aura que le choix de créer une instance ( ou bien de quitter si il le souhaite)

![Pasted image 20230113194528](https://user-images.githubusercontent.com/92815115/212397459-a83e7878-71e3-46da-a082-d5f5648f6737.png)

En sélectionannt ``create new instance`` , la création d'instance est initialisé.

On commence par utiliser la commande ``make init ``, pour initialiser terraform. Puis ``make plan``, pour préparer les resources pour l'instance et on finit par ``make apply`` pour créer l'instance.

![Pasted image 20230113194541](https://user-images.githubusercontent.com/92815115/212397432-ba32f9b2-fb17-4c07-b3f8-319ad698fc17.png)

**Notre instance est à ce moment créée 👍**

---

## 4. Processus d'installation de EMQX

Une fois l'instance créée, il faut maintenant installer emqx sur cette instance. *

![Pasted image 20230113194654](https://user-images.githubusercontent.com/92815115/212397416-dc8286f4-204d-4f71-a869-b4073f4bc14d.png)

On récupére donc son ip et on s'y connecte via ssh grâce à la commande ``./go`` suivi de l'ip .

Une fois connecté, le script ``deploy_emqx`` est envoyé à la VM grâce à la fonction ``EOF ``.

Il commence par mettre à jour et installer les packages nécessaires ( tels que git ).

La branche main est ensuite cloner sur l'instance via ``git`` .

On va commencer par l'éxécution du programme bash ``install-docker``, il va récupérer la version de docker que nous avons définit  ``5:20.10.13~3-0~ubuntu-jammy`` car nous avons initialiser une instance sous ubuntu 22. 

La fixation de la version permit aussi d'être sur du bon fonctionnement du script dans le cas on nous irions récupérer la dernière version de docker il est possible que certaines choses change set donc empêcher le bon fonctionnement du script.

Après avoir récupérer la version de docker, il l'installe et par la suite tester sur la commande ``docker`` est bien fonctionnelle ce qui nous certifie que docker a bien été installer.

Docker est désormais installé, nous passons donc au container EMQX.

Pour commencer, nous allons récupére l'image d'EMQX comme pour docker avec une version spécifique  ``5.0.9``.

L'image récupéré, il ne reste plus qu'a démarrer un container avec la commande ``docker run ``sur le port 18083 qui est le prot de définir pour les serveur EMQX.

On viens pour par tester le port 18083 sur l'ip de notre instance pour s'assurer de la réussite du script.

![Pasted image 20230113194813](https://user-images.githubusercontent.com/92815115/212397390-7f118460-257c-4414-bcfd-63b109129714.png)
	
**Notre container EMQX est désormais en ligne .**

## 5. Accéder au dashboard EMQX 

Une fois, l'installation de tous les éléments faits. Nous somme ramener sur la liste des instances. 

On peut maintenant sélectionner l'instance précédement créée, nous arrivons de ce fait sur un nouveau menu . 

Le menu de l'instance sélectionne a une unique option qui est ``open in browser`` qui ouvrira dans le navigateur firefox la page du dashboard EMQX correspondant à l'ip de l'instant sur le port 18083.

![Pasted image 20230113195348](https://user-images.githubusercontent.com/92815115/212397359-9666c757-25e9-4546-84c5-28c84263adb6.png)

**Voilà !**

Il ne reste plus qu'a se connecter avec les identifiants définis de base qui sont :
- *utilisateur* : **admin**
- *mot de passe* : **public**

Il vous sera juste demander de changer de mot de passe admin à la première connexion 

**Votre serveur EMQX est maintenant entièrement fonctionnel !**
