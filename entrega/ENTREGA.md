# Despliegue de Laravel en Vercel

Estos son los pasos que seguí para desplegar mi aplicación Laravel en Vercel. Tuve que adaptar bastante la estructura del proyecto porque Vercel no maneja PHP nativamente como otros lenguajes.

## Fuentes consultadas

Me apoyé en estas referencias para hacer el despliegue:

- Guía de Rezas Mandala: [How to deploy Laravel project to Vercel](https://rezamandala.medium.com/how-to-deploy-laravel-project-to-vercel-7b3c2800e974)
- Repositorio vercel-php: [vercel-php documentation](https://github.com/juicyfx/vercel-php)
- Documentación de Vercel: [Vercel Deployment Guide](https://vercel.com/docs)

## Proceso de despliegue

### Instalación de la CLI

Primero instalé la CLI de Vercel y vinculé el proyecto con:
```bash
vercel .
```

Durante la configuración usé estos valores:
- **Project Name:** laravel-1
- **Directory:** ./

### Reestructuración del proyecto

Como Vercel no soporta PHP como lo hace con Node.js, tuve que reorganizar algunos archivos:

1. Creé una carpeta `api/` en la raíz del proyecto
2. Moví el `index.php` de `public/` a `api/`
3. Actualicé las rutas en `api/index.php` para que apuntaran correctamente al autoload y al bootstrap:
```php
require __DIR__.'/../vendor/autoload.php';
$app = require_once __DIR__.'/../bootstrap/app.php';
```

### Configuración de vercel.json

Creé el archivo `vercel.json` en la raíz para definir el runtime de PHP y el enrutamiento:
```json
{
    "version": 2,
    "functions": {
        "api/index.php": { "runtime": "vercel-php@0.7.1" }
    },
    "routes": [
        {
            "src": "/(.*)",
            "dest": "/api/index.php"
        }
    ]
}
```

Esta configuración redirige todas las peticiones al archivo `index.php` dentro de la carpeta `api/`.

## Despliegue

Una vez configurado todo, desplegué a producción con:
```bash
vercel --prod
```

Y con eso quedó funcionando el proyecto en Vercel.