# README

## Version
### Ruby 2.6.6
### Rails 5.2.7

-------
## Model 關聯圖

![Image](https://github.com/kaichi1216/image_storage/raw/main/snapask_erm2.png)

-------
## 題目需求

* 需要有一個後台可以讓管理者管理教育課程
  - 完成
    1. 可以執行CRUD基本操作

    2. 若使用者不是管理員，則不允許操作(manager model)

    3. 可以設定課程主題

    4. 可以設定課程價格， 幣別

    5. 可以設定課程類型

    6. 可以設定課程上下架

    7. 可以設定課程URL，以及描述

    8. 可以設定課程效期 1天 ~ 1個月

* 這個平台可以讓用戶用API購買教育課程
  - 完成
    1. 購買後須建立購買紀錄(因題目需求不需串金流，所以簡化金流付款流程，假設每次交易結果都是成功)

    2. 若課程已下架，則不能進行購買

    3. 若使用者已購買過該課程，且目前還可以取用，則不允許重複購買

* 用戶可以用API瀏覽他所有購買過的課程
  - 完成
    1. 回傳結果要包含課程基本資料

    2. 回傳結果要包含所有跟該課程相關的付款資料

    4. 可以用過濾方式找出目前還可以上的課程
  - 未完成
    1. 可以用過濾方式找出特定類型的課程

-----



# API url

## heroku url: https://tranquil-hamlet-64279.herokuapp.com/

```
web課程管理後台登入帳密
manager 測試帳密
email: manager1@gmail.com
password: 123456

API user 測試帳密
email: test@gmail.com
password: 123456
```

## 登入API
```ruby
#url: https://tranquil-hamlet-64279.herokuapp.com/api/v1/login
#method: POST

request_body: {
    "email": STRING,
    "password": STRING
}

```

回傳狀態和訊息
  ```ruby
  #success
  status: 201
  response_body:
  {
    "token": STRING
  }
  #failed
  status: 400
  response_body:
  {
    "error": {
        "message": STRING 
    }
  }
  ```


  ## 付款API
```ruby
#url: https://tranquil-hamlet-64279.herokuapp.com/api/v1/purchase/:course_id
#method: POST
#request_headers Authorization欄位需帶上 token

request_body: {
    "pay_information":{
        "type": INTEGER
    }
}
```

回傳狀態和訊息
  ```ruby
  #success
  status: 201
  response_body:
  {
    "message": STRING
  }
  #failed course not exist
  status: 404
  response_body:
  {
    "message": "404 Not found"
  }
  ```


## 用戶購買過的課程列表API
```ruby
#url: https://tranquil-hamlet-64279.herokuapp.com/api/v1/account/courses
#method: GET
#request_headers Authorization欄位需帶上 token

#過濾找出還可以上的課程
#url: http://localhost:3000/api/v1/account/courses?filter_expire=true


```

回傳狀態和訊息
  ```ruby
  #success
  status: 200
  response_body:
  [
    {
        "expired_time": DATETIME,
        "course": {
            "id": INTEGER,
            "subject": STRING,
            "price": STRING,
            "currency": STRING,
            "launch": BOOLEAN,
            "url": STRING,
            "description": STRING,
            "expire_day": INTEGER,
            "category": {
                "id": INTEGER,
                "name": STRING
            }
        },
        "pay_information": {
            "total_price": STRING,
            "currency": STRING,
            "pay_type": INTEGER,
            "pay_time": DATETIME
        }
    },......
]
 
  ```