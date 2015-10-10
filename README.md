# Robokassa

> This is node module for robokassa.ru API

### Installation

```sh
$ npm install robo-kassa
```

### Usage:
```javascript
var Robokassa = require('robo-kassa');
var  robo = new Robokassa({
    login: "myLogin",
    password1: "myPassword1",
    password2: "myPassword2",
    test: true //false - default
});
/*
* create robokassa url
* return https://auth.robokassa.ru/Merchant/Index.aspx?MrchLogin=.... .... .....
*/
robo.createUrl({ id: "site invoice number", summ: 1500, description: "description of invoice"});
/*
* check payment params
* return true if success else return false
*/
robo.checkPaymentParams({
    OutSum: "1500"
    InvId: "site invoice number"
    SignatureValue: "MD5 signature"
});
```