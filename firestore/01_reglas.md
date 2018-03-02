# Reglas de Cloud Firestore

## Acceso total

⚠️ No usar esta regla en producción, expone toda la base de datos.

```
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write;
    }
  }
}
```

## Acceso total si el usuario está autenticado

```
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth.uid != null;
    }
  }
}
```

## Asegurado

```
service cloud.firestore {
  match /databases/{database}/documents {
    match /listas/{lista} {
      // Un usuario registrado puede crear una lista nueva
      allow create: if request.auth.uid != null &&      
                    request.resource.data.size() == 2 &&
                    request.resource.data.titulo is string && 
                    request.resource.data.propietario is string &&
                    request.resource.data.propietario == request.auth.uid;
      // Para leer y modificar una lista, tienes que ser el propietario
      allow read, update, delete: if request.auth.uid == resource.data.propietario;
    }    
  }
}
```

## Referencias

- [Overview](https://firebase.google.com/docs/firestore/security/overview)
- [Get started](https://firebase.google.com/docs/firestore/security/get-started)
- [Referencia de reglas](https://firebase.google.com/docs/firestore/reference/security/)
