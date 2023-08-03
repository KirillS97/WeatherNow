___
## Description
This application is designed to view the current weather in a specified location (town, village, etc.). The application contains 3 scenes:
* Main scene. The main scene is a collection of cells containing weather data in places added by the user;
* A scene containing a list of places. The list of places is a table with default cells containing the names of places added by the user. The table supports removing unnecessary places from the list;
* Location search scene. This scene is designed to search for a place and information about the weather in it, as well as to add this place to the list.

Data Persistance is implemented using User Defaults. Creating and sending a GET request to the server is implemented using the "Alamofire" framework, deserialization of data received from the server is implemented using the "JSONDecoder" class, whose object decodes the received data into an object of a structure that implements the "Codable" protocol.
___
## Описание
Данное приложение предназначено для просмотра текущей погоды в указанном месте (городе, населённом пункте и т.п.). Приложение содержит 3 сцены:
* Главная сцена. Главная сцена представляет из себя коллекцию ячеек, содержащих данные о погоде в местах, добавленных пользователем.
* Сцена, содердащая список мест. Список мест - это таблица со стандартными ячейками, отражающая названия мест, добавленные пользователем. Таблица поддерживает удаление ненужных мест из списка.
* Сцена поиска места. Эта сцена предназначена для поиска места и информации о погоде в нём, а также, для добавления этого места в список.

Долговременное хранение данных реализовано с помощью User Defaults. Создание и отправка GET-запроса на сервер реализована с помощью фреймворка "Alamofire", десериализация полученных с сервера данных реализована с помощью класса "JSONDecoder", объект которого декодирует полученные данные в объект структуры, реализующей протокол "Codable".
___
## Application work example:
![demo.gif](Demo.gif)
___