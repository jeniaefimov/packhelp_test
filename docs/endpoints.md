**POST /api/v1/users/create**

Request
```
{
  "name": "new user",
  "email": "email@packhelp.com"
}
```

Response 
```
{
  "id": 1,
  "name": "new user",
  "email": "email@packhelp.com",
  "total_orders_pln": "10",
  "total_orders_eur": "2"
}
```

**GET  /api/v1/users**

Response
```
[
    {
      "id": 1,
      "name": "new user",
      "email": "email@packhelp.com",
      "total_orders_pln": "10",
      "total_orders_eur": "2"
    },
    
    {
      "id": 1,
      "name": "new user 1",
      "email": "email1@packhelp.com",
      "total_orders_pln": "10",
      "total_orders_eur": "2"
    }
]
```

**GET  /api/v1/users/:id**
```
    {
      "id": 1,
      "name": "new user",
      "email": "email@packhelp.com",
      "total_orders_pln": "10",
      "total_orders_eur": "2"
    }
```
