# HelloID-Conn-Prov-Notification-MessageBirdSMS

| :warning: Warning |
|:---------------------------|
| Please be aware that the current notifications only can be triggered by built-in events.  |

| :information_source: Information |
|:---------------------------|
| This repository contains the connector and configuration code only. The implementer is responsible to acquire the connection details such as username, password, certificate, etc. You might even need to sign a contract or agreement with the supplier before implementing this connector. Please contact the client's application manager to coordinate the connector requirements.       |
<br />
<p align="center"> 
  <img src="https://developers.messagebird.com/img/glyph.svg">
</p>

## Table of contents

## Introduction

_HelloID-Conn-Prov-Notification-MessageBirdSMS_ is a _notifcation_ connector. MessageBird provides a set of REST APIs that allow you to programmatically interact with its data. The [MessageBird SMS API documentation](https://developers.messagebird.com/api/sms-messaging/#api-endpoint) provides details of API commands that are used.

## Table of contents

- [HelloID-Conn-Prov-Notification-MessageBirdSMS](#helloid-conn-prov-notification-messagebirdsms)
  - [Table of contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Table of contents](#table-of-contents-1)
  - [Getting started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Connection settings](#connection-settings)
    - [Templates](#templates)
      - [SMS](#sms)
  - [Getting help](#getting-help)
  - [HelloID docs](#helloid-docs)

## Getting started
### Prerequisites

  - API AccessKey from MessageBird  

### Connection settings

The following settings are required to connect to the API.

| Setting              | Description                                                | Mandatory |
| -------------------- | ---------------------------------------------------------  | --------- |
| BaseUri              | The BaseURI of the Messagebird API endpoint(s)             | Yes       |
| AccessKey            | AccessKey for Messagebird API. Follow the [MessageBird Tutorial on how to create the access key](https://developers.messagebird.com/tutorials/getting-started-101/)  | Yes       |
| Sending From         | The sender of the message. This can be a telephone number (including country code) or an alphanumeric string. In case of an alphanumeric string, the maximum length is 11 characters     | Yes       |

### Templates

There is one templates.
| :warning: Warning                                                                                                                           |
| :------------------------------------------------------------------------------------------------------------------------------------------ |
|                                                                                                                                             |
| Please keep in mind that the key form field names in the templates are used in the notification.ps1 changing them will break the connector. |

It is possible to hide or disable (make them read-only) certain form fields if they are not used or should not be changed. For example, the scriptFlow should always be 'SMS' and the field must be hidden in the configuration:

```JSON
  {
    "key": "scriptFlow",
    "type": "input",
    "defaultValue": "SMS",
    "templateOptions": {
      "label": "Script flow",
      "disabled": false
    },
    "hide": true
  },
```

#### SMS
To create a form for changes the following template should be used: [template_change.json](https://github.com/Tools4everBV/HelloID-Conn-Prov-Notification-MessageBirdSMS/blob/main/template_change.json).

The table below describes the different form fields from the template.

| template key              | Description                                                                      | Mandatory |
| ------------------------  | -------------------------------------------------------------------------------- | --------- |
| scriptFlow                | Fixed value "SMS" (read-only)                                                    | Yes       |
| Time                      | Optional, the scheduled time of the message in format HH:mm:ss                   | Yes       |
| Recipient mobile number   | Mobile number where SMS should be delivered                                      | Yes       |
| Recipient name            | Name of the recipient                                                            | No        |
| Message                   | Body of the SMS Message                                                          | Yes       |

## Getting help

> _For more information on how to configure a HelloID PowerShell connector, please refer to our [documentation](https://docs.helloid.com/en/provisioning/notifications--provisioning-/notification-systems--provisioning-) pages_

> _If you need help, feel free to ask questions on our [forum](https://forum.helloid.com/forum/helloid-connectors/provisioning/4929-helloid-conn-prov-notification-messagebirdsms)_

## HelloID docs

> The official HelloID documentation can be found at: https://docs.helloid.com/
