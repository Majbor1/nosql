---
marp: true
theme: default
paginate: true
size: 16:9
---

<!--
_class: lead invert
_paginate: false
-->

# XML & XSD
# Extensible Markup Language & XML Schema Definition

**Course:** NoSQL Databases

---

# XML
- Extensible Markup Language
- Strict textual markup format for structured data
- W3C Recommendation standard
- Widely used in legacy APIs (SOAP), enterprise integration, and data exchange
- Native support for document validation and complex metadata (attributes + elements)

---

# Manuals and Tutorials
- [W3Schools XML Tutorial](https://www.w3schools.com/xml/)
- [W3C XML Schema Definition (XSD)](https://www.w3.org/XML/Schema)

---

# XML Main Structure

- **Prolog:** Document declaration (e.g., `<?xml version="1.0" encoding="UTF-8"?>`)
- **Tree Structure:** Single root element containing child elements
- **Elements & Tags:** Enclosed in `<tag>` and `</tag>`
- **Attributes:** Name-value pairs inside opening tags (`<element attr="value">`)

---

# XML Example

```xml
<?xml version="1.0" encoding="UTF-8"?>
<student>
    <firstName>John</firstName>
    <lastName>Doe</lastName>
    <isEnrolled>true</isEnrolled>
    <semester>5</semester>
    <subjects>
        <subject>math</subject>
        <subject>computer science</subject>
        <subject>history</subject>
    </subjects>
    <address city="Krakow" country="Poland" />
</student>
```

---

# Common Syntax Errors

- Unclosed tags or mismatched tag names (case-sensitive!)
- Missing single root element (multiple top-level nodes)
- Unquoted attribute values
- Improperly nested tags (e.g.,

```xml
<a><b></a></b>
```

---

# Syntax Errors Example

```xml
1.  <?xml version="1.0"?>
2.  <store isOpen=true>
3.    <name>Green Grocery</Name>
4.    <employeeCount>5</employeeCount>
5.    <categories>
6.      <category>fruit
7.      <category>vegetables</category>
8.    </categories>
9.  </store>
10. <store>Another Store</store>
```

---

# XML Schema (XSD)

## Get Started with XSD
- Validates XML structure, data types, and element ordering
- Defines element cardinality (minOccurs, maxOccurs)
- Supports namespaces and complex type declarations

---

# XSD Example

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:xs="[http://www.w3.org/2001/XMLSchema](http://www.w3.org/2001/XMLSchema)">
  <xs:element name="user">
    <xs:complexType>
      <xs:sequence>
        <xs:element name="id" type="xs:integer"/>
        <xs:element name="username" type="xs:string"/>
        <xs:element name="email" type="xs:string"/>
        <xs:element name="age" type="xs:integer"/>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
</xs:schema>
```

---

# XML & XSD Validators

- Any Web Browser
- VS Code Extensions: Red Hat XML, XML Tools
- Online Validators
- CLI / Tools: xmllint, Saxon

---

<!--
_class: lead invert
_paginate: false
-->

# Practical Tasks

---

# Task 1: Building Nested XML Structure

Design and create an XML file named ```inventory.xml``` to manage an electronics store's stock. The root element must be ```<inventory>``` containing:

1. Store metadata attributes or elements: ```storeName``` (string), ```isActive``` (boolean), and ```lastUpdated``` (ISO-8601 string).

---

2. A ```<products>``` container element holding at least 3 ```<product>``` elements. Each product must include:

- ```id``` attribute or element (integer)
- ```<name>``` (string)
- ```<price>``` (decimal/number)
- ```<tags>``` containing multiple <tag> elements
- ```<specs>``` (nested element with ```<manufacturer>``` and ```<warrantyMonths>```).

---

# Task 2: Fixing XML Data

In ```server_config.xml```:

- Remove all syntax errors (well-formedness errors)
- Format the XML properly

---

# Task 3: Data Refactoring

You are provided with a flat XML file ```courses.xml```:

```xml
<courses>
  <course code="CS101">
    <title>Introduction to SQL</title>
    <instructor>John Doe</instructor>
  </course>
</courses>
```

---

Refactor and expand this document so that:

- The root element is ```<universityData>``` with attributes ```university="Tech University"``` and ```semester="5"```.

- The ```<instructor>``` element is converted into a complex element with ```<fullName>```, ```<academicTitle>```, and ```<email>```.

- An ```<enrolledStudents>``` element is added to each course, containing multiple ```<student>``` nodes with ```studentId``` and optional ```<finalGrade>```.

---

# Task 4: Creating Basic Schema (XSD)

Create an XSD schema named ```product_schema.xsd``` to validate catalog items for an online store:

- Validate a single ```<product>``` root element.
- Define rules and data types:
  - ```productId``` (attribute or element): Must be xs:integer.
  - ```<title>```: xs:string with minimum length 3.
  - ```<price>```: xs:decimal with minimum value 0.01.
  - ```<category>```: Restricted via xs:restriction to values: "electronics", "books", "clothing".
  - ```<inStock>```: xs:boolean.
- Require all fields and validate ```product.xml``` against it.

---

# Task 5: Schema Binding

You are provided with a pre-configured schema ```user_schema.xsd```.

Using this XSD, validate the provided ```user.xml``` file. Fix all schema validation errors in ```user.xml``` to make it fully compliant.

---

# Task 6: Validating Complex Structures

Design a comprehensive XSD named ```order_schema.xsd``` to validate a customer purchase order:

- Root element ```<order>``` with properties:
  - ```<orderId>``` (string)
  - ```<customer>``` containing ```<fullName>``` and ```<email>```
  - ```<items>``` containing 1 or more ```<item>``` elements (sku, quantity, unitPrice)
  - ```<status>``` enum: "pending", "shipped", "delivered", "cancelled".
- Verify that adding an unapproved element/attribute (e.g. ```<discountCode>```) triggers a validation error.
  