- [ALTENNavigation](#altennavigation)
  - [Introducción](#introducción)
  - [Instalación](#instalación)
    - [Añadir al proyecto](#añadir-al-proyecto)
    - [Como dependencia en Package.swift](#como-dependencia-en-packageswift)
  - [Cómo se usa](#cómo-se-usa)
    - [`ALTENNavigationView`](#altennavigationview)
    - [`NavigableView`](#navigableview)
    - [`NavigationActions`](#navigationactions)
    - [Limitaciones](#limitaciones)

# ALTENNavigation
- Changelog: https://github.com/SDOSLabs/ALTENNavigation/blob/main/CHANGELOG.md

## Introducción
`ALTENNavigation` es una librería que proporciona un nuevo componente de navegaicón para `SwiftUI` encapsulando el componente de navegaciónde `UIKit` `UINavigationController`. Principalmente proporciona las siguientes funcionalidades:
- Proporciona un mecanismo de navegación imperativo, similar al implementado en `UIKit` usando el nuevo `NavigationActions`
- Facilita navegaciones de tipo Deep Link
- Este nuevo flujo de trabajo inutiliza el traspaso de variables de entornos cuando se realiza la navegación entre las vistas. 
  
En resumen, esta librería nos permite desarrollar todas las vistas y la navegación en con el framework de `SwiftUI` pero usando por detrás el componente `UINavigationController` de `UIKit`

## Instalación

### Añadir al proyecto

Abrir Xcode y e ir al apartado `File > Add Packages...` y en el cuadro de búsqueda introducir la url del respositorio y seleccionar la versión:
```
https://github.com/SDOSLabs/ALTENNavigation.git
```

### Como dependencia en Package.swift

``` swift
dependencies: [
    .package(url: "https://github.com/SDOSLabs/ALTENNavigation.git", .upToNextMajor(from: "1.0.0"))
]
```

Se debe añadir al target de la aplicación en la que queremos que esté disponible

``` swift
.target(
    name: "MyTarget",
    dependencies: [
        .product(name: "ALTENNavigation", package: "ALTENNavigation")
    ]),
```

## Cómo se usa

### `ALTENNavigationView`
Para empezar a usar el nuevo flujo de navegación se debe encapsular un `View` que implemente el protocolo `NavigableView` dentro del componente `ALTENNavigationView`:

``` swift 
struct RootView: View {
    
    var body: some View {
        ALTENNavigationView(identifier: "root") { navigationActions in
            FirstView()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct FirstView: NavigableView {
    public var navigationIdentifier: String { String(describing: type(of: self).self) }
    @Environment(\.navigationActions) var navigationActions

    var body: some View {
        Text("This is the first View")
    }
}
```

A partir de aquí cada vista a la que se quiera navegar deberá implementar el protocolo `NavigableView`. Este protocolo proporciona dos funcionalidades:
- Cada vista debe tener un `navigationIdentifier` que permitirá controlar los flujos de navegación para realizar operaciones de `pop` o `dimiss`. Debe ser único.
- Cada vista puede implementar el método `applyNavigationStyle` para personalizar el aspecto visual de la barra de navegación.

### `NavigableView`

Hay varias formas de implementar el procotolo `NavigableView`:
- Implementando en la vista el protocolo `NavigableView` directamente:
  ```swift
  struct FirstView: NavigableView {
      public var navigationIdentifier: String { String(describing: type(of: self).self) }
      @Environment(\.navigationActions) var navigationActions

      var body: some View {
          Text("This is the first View")
      }
  }
  ```

- Usando la función `navigableView` que implementa el protocolo `View` y que devuelve un tipo `AnyNavigableView`
  ```swift
  struct FirstView: View {
      var body: some View {
          Text("This is the first View")
      }
  }

  [...]
  FirstView().navigableView("FirstView", navigationActions: nil, style: nil)
  ```
  Para que la vista tenga capacidades de navegación es necesario pasar un valor válido al parámetro `navigationActions`. Hay que extraerlo del contexto de navegación actual obteniendolo de las variables de entorno.

### `NavigationActions`

Las vistas de tipo `NavigableView` tienen disponible una variable de entorno bajo el identificador `navigationActions`. Estas acciones permiten realizar las navegaciones de tipo `push` o `modal` a otras pantallas. Para extraer la varible de entorno sólo es necesario incluir la siguiente línea `@Environment(\.navigationActions) var navigationActions`:

``` swift
struct RootView: View {
    var body: some View {
        ALTENNavigationView(identifier: "root") { navigationActions in
            FirstView()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct FirstView: NavigableView {
    public var navigationIdentifier: String { String(describing: type(of: self).self) }
    @Environment(\.navigationActions) var navigationActions
    
    var body: some View {
        VStack {
            Text("This is the first view")
            Button("Go to Second View") {
                navigationActions?.pushActions?.push(SecondView(), animated: true)
            }
        }.navigationBarTitle(Text("First"))
    }
}

struct SecondView: NavigableView {
    public var navigationIdentifier: String { String(describing: type(of: self).self) }
    @Environment(\.navigationActions) var navigationActions
    
    var body: some View {
        Text("This is the second view")
            .navigationBarTitle(Text("Second"))
    }
}
```

La variable `navigationActions` se podrá usar para hacer navegaciones de tipo `push` usando la propiedad `pushActions`. Esta propiedad sólo existe si la vista está embebida en un `ALTENNavigationView`.

También se podrá usar navegaciones de tipo `modal` usando la propiedad `modalActions`. Esta propiedad siempre existe.

### Limitaciones
- No se debe usar el componente nativo `NavigationLink` para realizar navegaciones.
- Las variables `@Environment` no se traspasan entre las vistas cuando se realiza una navegación de cualquier tipo. Cada navegación inicia un nuevo contexto de vistas.
