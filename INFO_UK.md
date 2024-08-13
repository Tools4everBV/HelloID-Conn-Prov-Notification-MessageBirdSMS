The identity & access management (IAM) solution HelloID by Tools4ever uses notifications to keep users informed about significant events. HelloID uses email notifications for this purpose. However, with the Bird Connector, HelloID also integrates with Bird, a platform that offers SMS communication services. This connector enables the automation of sending SMS notifications, either supplementing or replacing the standard email notifications. This article provides more information about this connector and its functionalities.

## What is Bird?

Bird is a solution provided by the company of the same name that allows organisations to send text messages for notifications, marketing, and communications. Every year, Bird’s customers send around 5 trillion messages through SMS, email, and WhatsApp. With this service, customers can integrate SMS notifications into various platforms. Bird, originally founded as MessageBird in 2011, emerged from Mollie, which spun off various business activities. The company has been known as Bird since 2024.

## Why is a Bird integration useful?

The Bird Connector from HelloID provides several benefits for customers. For example, SMS notifications facilitate swift and direct communication with users. Additionally, businesses can set up an alternative channel for notifications alongside email. This ensures that users see notifications as quickly as possible and enables effective communication with users who rarely or never use email. Integrating with Bird allows businesses to cater to diverse communication preferences among users.

## How HelloID communicates via Bird

HelloID uses the Bird Connector to send SMS notifications to users based on specific events or actions. For instance, when a new user is created in HelloID, the IAM solution can automatically send a welcome SMS via Bird to the new user. This immediately and effectively welcomes new users, informing them about their account details and important information.

The Bird Connector acts as a notification connector within HelloID. It receives notifications from HelloID and forwards them via SMS to the appropriate recipients. For sending and receiving SMS messages, HelloID utilises the APIs provided by Bird.

## Benefits of using HelloID with Bird

The use of SMS notifications offers several advantages, which include:

| Benefit | Explanation |
| ------------------- | ------------------- | 
| Rapid communication |	Integration with Bird enables important messages to be delivered directly to users via SMS. This speeds up communication with users, ensuring they receive the right notification at the right time. |
| Increased responsiveness |	Users receive notifications more quickly, enabling them to respond sooner to critical situations. This is crucial, as some scenarios simply cannot wait and require immediate action. For example, issues with the automated creation of a user account that prevent a user from starting work, or the unexpected deletion of a user from your source system, where you need to ensure that the user's authorisations have been revoked.|
|Reliability |	With SMS notifications, you have an alternative communication channel alongside email notifications. This is beneficial because emails can sometimes get caught in spam filters. It also prevents users from missing notifications due to issues with an email server, for instance. SMS notifications enhance the reliability of your notifications.| 
| Improved communication reach |	SMS notifications increase your communication reach. Not every user regularly checks their email account, meaning email notifications can go unnoticed. | 


## Data exchange between HelloID and Bird

For sending SMS notifications, HelloID exchanges various types of information with the Bird Connector, including:

* **User information:** This includes basic details such as the user's phone number.
* **Notification content:** The text that will be sent as the SMS notification.
*	**Sending status:** A confirmation of whether the message was delivered, to verify the notification was successful.

## Customising data exchange

One of the advantages of using HelloID is that it puts you firmly in control. The integration with Bird is designed to be highly customisable. You can tailor the data exchange between HelloID and Bird by setting up specific SMS templates and defining rules that trigger notifications based on certain events within HelloID.

Additionally, you can specify exactly when HelloID sends out SMS messages, ensuring they are always timely and relevant to both the organisation's needs and user preferences. For example, you can configure the system to avoid sending non-urgent notifications outside business hours or to ensure that new users receive a welcome message precisely when they arrive on their first day.

## Integrating HelloID with other systems

HelloID offers more than 200 connectors, allowing you to integrate the IAM solution with almost all popular source and target systems.
