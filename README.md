# meteorJsContact

*Контактный чат для вебсайта*

### Два варианта работы

- авторизованный
- анонимный

### 

### Фичи клиента

#### Отправка сообщения 

#### Список сообщений

#### Шапка

- картинка оператора 50x50px
  - Session.get 'oprImg'
- имя оператора           
  - Session.get 'oprName'
- информация оператора     
  - Session.get 'oprInfo'

#### Рабочее

@todo (вопрос как к вам обращаться)

- список сообщений
- поле ввода сообщения
- btn отправить
- btn авторизация

![client](https://raw.github.com/alexsuslov/meteorJsContact/dev/help/client.jpg)


## Сервер

### collection host (дизайн для хоста)

host     :  String для проверки
hash     :  String для авторизации веб
css      :  string 

### collection msg (Сообщения)

- owner:  клиент
- session: Сессия чата
- msg:  сообщения
