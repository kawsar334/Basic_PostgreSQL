
### 1 1️⃣ PostgreSQL কী?

PostgreSQL একটি ওপেন সোর্স, শক্তিশালী এবং object-relational ডেটাবেইজ ম্যানেজমেন্ট সিস্টেম (ORDBMS), যা ANSI-SQL এর স্ট্যান্ডার্ড মেনে চলে। এটি ACID (Atomicity, Consistency, Isolation, Durability) properties ফলো করে এবং বড় আকারের enterprise-level অ্যাপ্লিকেশন তৈরি করার জন্য উপযুক্ত। PostgreSQL JSON, XML, এবং custom data types সাপোর্ট করে।

উদাহরণস্বরূপ, PostgreSQL ব্যবহার করে আমরা বড় আকারের ওয়েব অ্যাপ্লিকেশনের ইউজার, পণ্য, অর্ডার ইত্যাদি ডেটা নিরাপদভাবে সংরক্ষণ করতে পারি।

---

### 2. PostgreSQL-এ একটি database schema এর কাজ কী?

Schema হলো একটি logical structure যা ডেটাবেইজের টেবিল, ভিউ, ফাংশন, এবং অন্যান্য অবজেক্টগুলিকে গ্রুপ করে। এটি এক ডেটাবেইজে একাধিক ইউজার বা অ্যাপ্লিকেশনকে আলাদা পরিবেশে কাজ করার সুযোগ দেয়।

উদাহরণ:  
একটি ডেটাবেইজে `public` এবং `admin` নামে দুটি schema থাকতে পারে। `public` schema-তে ইউজার সম্পর্কিত টেবিল থাকতে পারে, আর `admin` schema-তে শুধুমাত্র অ্যাডমিন ফাংশন ও রিপোর্টিং টেবিল থাকতে পারে।

---

### 3️ . Primary Key এবং Foreign Key ধারণাগুলো ব্যাখ্যা করুন।

**Primary Key**: এটি একটি কলাম বা কলামসমূহের সংমিশ্রণ যা প্রতিটি রেকর্ডকে ইউনিকভাবে শনাক্ত করে। এর মান null হতে পারে না এবং পুনরাবৃত্তি হয় না।

**Foreign Key**: এটি একটি কলাম যা অন্য টেবিলের Primary Key এর সাথে সম্পর্ক স্থাপন করে। এর মাধ্যমে ডেটার মধ্যে সম্পর্ক তৈরি হয় এবং referential integrity বজায় থাকে।

উদাহরণ:
```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id),
  order_date DATE
);
```

### 4 SELECT statement-এ WHERE clause এর উদ্দেশ্য কী?
WHERE clause ব্যবহার করে নির্দিষ্ট শর্ত অনুযায়ী ডেটা নির্বাচন করা হয়। এটি ডেটাবেইজ থেকে প্রয়োজনীয় রেকর্ড ফিল্টার করে। 

```bash 

SELECT * FROM users WHERE age > 18;
```


### 5.PostgreSQL-এ COUNT(), SUM(), এবং AVG() এর মত aggregate functions কীভাবে গণনা করা হয়?
Aggregate Functions ডেটার উপর গাণিতিক সংক্ষেপণ করে ফলাফল প্রদান করে। PostgreSQL-এ এই ফাংশনগুলোর সাহায্যে বড় ডেটা থেকে বিভিন্ন পরিসংখ্যান বের করা যায়।

- COUNT() একটি টেবিলে মোট কতটি রেকর্ড আছে তা গণনা করে।

- SUM() কোনো numeric কলামের মোট যোগফল দেয়।

- AVG() কোনো numeric কলামের গড় মান দেয়।

```bash 
SELECT COUNT(*) FROM orders;
SELECT SUM(price) FROM products;
SELECT AVG(age) FROM users;


```