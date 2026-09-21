# DP-800 Laboratorio 02: Objetos de Base de Datos en Azure / SQL Server (AdventureWorksLT)

Este repositorio contiene la documentación y los scripts SQL desarrollados durante el **Laboratorio 02 del curso DP-800**, enfocados en la creación y administración de objetos avanzados de bases de datos utilizando la base de datos de ejemplo `AdventureWorksLT`.

---

## 🛠️ Contenido del Laboratorio

El laboratorio abarca la implementación práctica de los siguientes componentes en T-SQL:

1. **Vistas (Views):**
   - Creación de vistas para simplificar consultas relacionales complejas entre clientes y pedidos (`SalesLT.vCustomerOrders`).
2. **Procedimientos Almacenados (Stored Procedures):**
   - Lógica transaccional para procesar e insertar líneas de pedidos (`dbo.AddOrderLineItem`), incluyendo control de errores, validaciones y actualización automática de subtotales en la cabecera.
3. **Funciones (User-Defined Functions - UDFs):**
   - **Función Escalar:** Cálculo del total de un pedido de forma dinámica (`dbo.fnOrderTotal`).
   - **Función de Valor de Tabla en Línea (Inline TVF):** Consulta parametrizada de los pedidos por cliente (`dbo.GetCustomerOrders`), combinada con el operador `CROSS APPLY`.
4. **Disparadores (Triggers):**
   - Auditoría automática de cambios en los totales de los pedidos (`SalesLT.trg_LogOrderTotalChange`) ante operaciones de inserción y actualización (`INSERT`, `UPDATE`) en los detalles de las órdenes.

---

## 🚀 Cómo Utilizar Estos Scripts

1. Abre tu entorno de desarrollo SQL favorito (como *Azure Data Studio* o *SQL Server Management Studio - SSMS*).
2. Conéctate a una instancia que contenga la base de datos de prueba **AdventureWorksLT**.
3. Ejecuta los bloques de código secuencialmente según las secciones del laboratorio para crear las vistas, funciones, procedimientos y triggers correspondientes.

---

## 📝 Autor / Referencia
* **Curso:** DP-800 (Administración y Diseño de Bases de Datos / Plataformas de Datos)
* **Base de datos:** AdventureWorksLT
