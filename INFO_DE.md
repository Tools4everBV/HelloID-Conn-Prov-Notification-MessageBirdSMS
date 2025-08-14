Die IAM-Lösung HelloID von Tools4ever nutzt Benachrichtigungen, um Nutzer über wichtige Ereignisse zu informieren. Standardmäßig verwendet HelloID hierfür E-Mail-Benachrichtigungen. Über den Bird Connector, früher bekannt als MessageBird, integriert sich die Lösung jedoch auch mit Bird, einer Plattform für unter anderem SMS-Kommunikation. Dieser Connector automatisiert das Versenden von SMS-Benachrichtigungen als Ergänzung oder Ersatz für die Standard-E-Mail-Benachrichtigungen. In diesem Artikel erfahren Sie mehr über diesen Connector und seine Möglichkeiten.

## Was ist Bird?

Bird ist eine Lösung des gleichnamigen Unternehmens, mit der Organisationen Textnachrichten für unter anderem Benachrichtigungen, Marketing und Kommunikation einsetzen können. Jährlich versenden Kunden von (Message)Bird rund 5 Billionen Nachrichten über SMS, E-Mail und WhatsApp. Mit der Lösung können Kunden unter anderem SMS-Benachrichtigungen in verschiedene Systeme integrieren. Bird ist ein niederländisches Unternehmen, das 2011 als Bird gegründet wurde. Es entstand aus Mollie, das damals verschiedene Geschäftsaktivitäten auslagerte. Seit 2024 trägt das Unternehmen den Namen Bird.

## Warum ist eine Bird-Integration nützlich?

Der Bird Connector von HelloID bietet Kunden zahlreiche Vorteile. So ermöglichen SMS-Benachrichtigungen eine schnelle und direkte Kommunikation mit Nutzern. Unternehmen können ein alternatives Kommunikationskanal für Benachrichtigungen neben E-Mail einrichten. Dadurch stellen Sie sicher, dass Benutzer Benachrichtigungen so schnell wie möglich sehen, und Sie können effektiv mit Nutzern kommunizieren, die selten oder gar nicht E-Mail nutzen. Die Integration mit Bird ermöglicht es auch, auf verschiedene Kommunikationspräferenzen der Nutzer einzugehen.

## Wie HelloID über Bird kommuniziert

HelloID verwendet den Bird Connector, um SMS-Benachrichtigungen an Nutzer basierend auf spezifischen Ereignissen oder Aktionen zu senden. Stellen Sie sich zum Beispiel die Erstellung eines neuen Benutzers in HelloID vor. Die IAM-Lösung kann auf Wunsch automatisch über Bird eine Willkommens-SMS an den neuen Nutzer senden. So können Sie neue Nutzer direkt und effektiv willkommen heißen und über ihre Kontodaten und wichtige Informationen informieren.

Der Bird Connector fungiert als Benachrichtigungsconnector innerhalb von HelloID. Der Connector empfängt Benachrichtigungen von HelloID und sendet sie per SMS an die richtigen Empfänger. Für das Senden und Empfangen von SMS-Nachrichten nutzt HelloID die APIs von Bird.

## Vorteile der Nutzung von HelloID mit Bird

Das Nutzen von SMS-Benachrichtigungen bietet verschiedene Vorteile, von denen wir einige erläutern:

| Vorteil                  | Erläuterung                                                                                                                                                                        |
|--------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Schnelle Kommunikation**    | Die Integration mit Bird ermöglicht es, wichtige Nachrichten direkt per SMS an Nutzer zu übermitteln. So können Sie die Kommunikation mit Nutzern beschleunigen und sicherstellen, dass sie die richtige Benachrichtigung zur rechten Zeit erhalten. |
| **Erhöhte Responsivität**     | Nutzer erhalten Benachrichtigungen schnell und können dadurch früher auf kritische Situationen reagieren. Dies ist wichtig, da einige Situationen einfach nicht warten können und sofortiges Handeln erfordern. Denken Sie dabei an Probleme mit der automatisierten Erstellung eines Nutzerkontos, wodurch ein Nutzer nicht arbeiten kann. Oder die unerwartete Löschung eines Nutzers aus Ihrem Quellsystem, wobei Sie sicherstellen möchten, dass die Berechtigungen dieses Nutzers entzogen werden.  |
| **Zuverlässigkeit**        | Mit SMS-Benachrichtigungen verfügen Sie neben E-Mail-Benachrichtigungen über einen alternativen Kommunikationskanal. Dies ist angenehm, denn E-Mails können zum Beispiel unvorhergesehen im Spam-Filter hängen bleiben. Auch verhindern Sie, dass Benutzer durch beispielsweise Probleme mit einem Mailserver Benachrichtigungen nicht oder verspätet erhalten. SMS-Benachrichtigungen erhöhen somit die Zuverlässigkeit der Benachrichtigungen.   |
| **Verbesserte Reichweite** | Durch SMS-Benachrichtigungen verbessern Sie die Reichweite der Kommunikation. So überprüft nicht jeder Nutzer regelmäßig sein E-Mail-Konto, wodurch E-Mail-Benachrichtigungen übersehen werden können.                                                      |

## Datenaustausch zwischen HelloID und Bird

Zum Versenden von SMS-Benachrichtigungen tauscht HelloID verschiedene Informationen mit dem Bird Connector aus. Dazu gehören:

* **Nutzerinformationen:** Dabei handelt es sich um Basisdaten wie die Telefonnummer des Nutzers.
* **Benachrichtigungsinhalt:** Der textuelle Inhalt der SMS-Benachrichtigung.
* **Sende-Status:** Eine Bestätigung des Zustellstatus der Nachrichten, damit sofort ersichtlich ist, ob das Senden erfolgreich war.

## Maßgeschneiderter Datenaustausch

Ein Vorteil von HelloID ist, dass Sie stets die Kontrolle behalten. Die Integration mit Bird bildet hier keine Ausnahme. Sie können den Datenaustausch zwischen HelloID und Bird in erheblichem Maße nach Ihren Wünschen anpassen. Dies geschieht durch das Konfigurieren spezifischer Vorlagen für SMS-Nachrichten und das Definieren von Regeln für das Aktivieren von Benachrichtigungen basierend auf Ereignissen in HelloID.

Außerdem können Sie in der IAM-Lösung den genauen Zeitpunkt wählen, zu dem HelloID SMS-Nachrichten sendet, sodass diese immer optimal den Bedürfnissen und Präferenzen sowohl der Organisation als auch der Nutzer entsprechen. Auf diese Weise können Sie beispielsweise vermeiden, dass HelloID weniger wichtige SMS-Benachrichtigungen außerhalb der Arbeitszeiten versendet. Oder sicherstellen, dass neue Nutzer bei Beginn ihres ersten Arbeitstags zur erwarteten Ankunftszeit im Büro eine Willkommensnachricht erhalten.

## Integration von HelloID mit anderen Systemen

Für HelloID bieten wir mehr als 200 Connectoren an. Damit kann die IAM-Lösung in nahezu alle gängigen Quell- und Zielsysteme integriert werden.