# 🛠️ SwiftCLIGenerator

Un generador de módulos para crear automáticamente pantallas en proyectos iOS con arquitectura modular (por ejemplo: View, ViewModel, Coordinator).

---

## 🚀 ¿Qué hace?

Crea carpetas y archivos base para una nueva pantalla, incluyendo:

- ViewController con template customizable
- ViewModel (opcional) con template
- Header automático con autor, fecha y copyright
- Estructura de carpetas organizada por módulo

---

## 📦 Estructura generada

Ejemplo al ejecutar:

```bash
swift run SwiftCLIGenerator Example FirstScreen --viewmodel --company "R/GA"
```

Se genera:
```
Example/
├── View/
│   └── FirstScreenViewController.swift
└── ViewModel/
    └── FirstScreenViewModel.swift
```

El encabezado:
```
//
//  FirstScreenViewController.swift
//  Example
//
//  Created by Joni on 18/05/2025.
//  Copyright © 2025 R/GA. All rights reserved.
//
```

---

## 🧪 Cómo usar
    1.    Cloná o descargá este repo
    2.    Abrí Terminal en la carpeta raíz del proyecto
    3.    Corré:
    
## Parametros
    •    <Modulo>: nombre de la carpeta principal (ej: Onboarding)
    •    <NombrePantalla>: nombre base del componente (ej: FirstScreen)
    •    --viewmodel: opcional, agrega un ViewModel asociado
    •    --company: opcional, personaliza el nombre de la empresa en el header (por defecto: MyCompany)
    
---

### Como funciona
    •    Usa plantillas .template.swift que están en la carpeta Templates/
    •    Inserta valores dinámicos como:
    •    {{ModuleName}}
    •    {{ScreenName}}
    •    {{FileName}}
    •    Agrega un encabezado automático personalizado
