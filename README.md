[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/Wd8cPzIQ)
# Laboratorio 0 — Git y GitHub para firmware embebido

[![Git](https://img.shields.io/badge/Git-2.43%2B-F05032.svg?logo=git&logoColor=white)](https://git-scm.com/)
[![GitHub Classroom](https://img.shields.io/badge/GitHub-Classroom-181717.svg?logo=github)](https://classroom.github.com/classrooms/274591709-mmue-arquitectura-sistemas-embebidos-2026)
[![Git: LearnGitBranching](https://img.shields.io/badge/Git-learn_git_branching-blue.svg)](https://learngitbranching.js.org/)

Práctica introductoria de la asignatura **Ingeniería de Software de Sistemas Embebidos (S1)**. Antes de escribir una línea de firmware hay que dominar la herramienta que sostendrá todo el trabajo del curso: **Git**.

---

## Tabla de contenidos

- [Contexto](#contexto)
- [Objetivos](#objetivos)
- [Antes de empezar](#antes-de-empezar)
- [Flujo con GitHub Classroom](#flujo-con-github-classroom)
- [Estructura del repositorio](#estructura-del-repositorio)
- [Ejercicios](#ejercicios)
- [Integración continua](#integración-continua)
- [Hitos sugeridos](#hitos-sugeridos)
- [Errores frecuentes](#errores-frecuentes)
- [Rúbrica](#rúbrica)

---

## Contexto

Los laboratorios de esta asignatura son incrementales: el código que escribas en Lab 1 evoluciona en Lab 2, y así sucesivamente. Git no es solo una herramienta de entrega — es la memoria del proyecto, el sistema de seguridad y el canal de comunicación con el profesor. Aprenderlo bien aquí evita perder trabajo más adelante.

---

## Objetivos

Al finalizar esta práctica deberás ser capaz de:

- Crear commits atómicos con mensajes claros en formato Conventional Commits.
- Gestionar ramas: crear, cambiar, fusionar y eliminar.
- Leer el historial y navegar por él con referencias relativas.
- Deshacer cambios de forma segura sin perder trabajo.
- Sincronizar con un remoto y abrir un pull request en GitHub.

---

## Antes de empezar

### Prerrequisitos de software

- Git for Windows ≥ 2.43 instalado y configurado con nombre y email.
- Cuenta de GitHub activa con acceso a la organización del curso.

Comprueba que tu identidad Git está configurada antes de hacer el primer commit:

```bash
git config --global user.name
git config --global user.email
```

### Prerrequisito de teoría — learngitbranching.js.org

**Completa los siguientes niveles antes de empezar cada ejercicio.** El simulador te permite equivocarte sin consecuencias y construye la intuición necesaria para trabajar en un repo real.

| Ejercicio | Niveles a completar antes |
|-----------|--------------------------|
| A — Commits | Main → Introduction Sequence 1, 2 |
| B — Ramas y merge | Main → Introduction Sequence 3, 4 |
| C — Historial | Main → Ramping Up 1, 2 |
| D — Tag | Main → A Mixed Bag 1 |
| E — Remoto y PR | Remote → Push & Pull 1, 2, 3, 4 |

---

## Flujo con GitHub Classroom

1. **Acepta la tarea** desde el enlace del campus virtual. GitHub Classroom crea un repositorio privado a tu nombre dentro de la organización.
2. **Clona tu repositorio** en local y ábrelo en VS Code.
3. **Trabaja** siguiendo los ejercicios de este README. Cada hito funcional merece un commit.
4. **Sube tus cambios** con frecuencia — cada push actualiza el feedback de la CI.
5. **Consulta los resultados** en la pestaña **Actions** de tu repositorio.

La entrega es automática: el profesor revisa el repositorio en la organización antes de la fecha límite.

---

## Estructura del repositorio

```text
Raíz del repositorio/
├── README.md
├── .gitignore
├── sandbox/
│   ├── blink.c    ← modifica este archivo en los ejercicios A, B y E
│   └── config.h   ← modifica este archivo en el ejercicio A
└── scripts/
    └── check_git.sh    ← validador local del historial (ejecutar desde la raíz)
```

---

## Ejercicios

> **Convención de mensajes de commit** — todos los commits de esta práctica deben seguir el formato [Conventional Commits](https://www.conventionalcommits.org/es/v1.0.0/): `tipo(lab0): descripción en imperativo`. Los tipos válidos son `feat`, `fix`, `docs`, `chore`.

---

### Ejercicio A — Commits básicos

> Completa primero: learngitbranching → Main → Introduction Sequence 1 y 2.

**Qué debes lograr:** que el historial de `main` muestre al menos 3 commits tuyos, cada uno con un cambio coherente y un mensaje descriptivo.

Los cambios deben ser en los archivos de `sandbox/`:

- Un commit que identifique al autor en `blink.c`.
- Un commit que modifique el valor de `BLINK_DELAY_MS` en `config.h`.
- Un commit que añada contenido en el cuerpo de `blink_init` en `blink.c` (puede ser pseudocódigo en comentarios).

**Pistas:**

- Cada commit debe contener un único cambio coherente, no todos los cambios juntos.
- Antes de crear cada commit, comprueba qué hay en el staging area.
- Usa `git log --oneline` para verificar el historial tras cada commit.

**Comprueba tu progreso:**

| Dónde | Cómo | Qué debes ver |
|-------|------|---------------|
| Local | `bash scripts/check_git.sh` | Checks de commit count y formato en verde |
| Remoto | `git push` → pestaña **Actions** → `check_git.yml` | Los mismos checks pasan en el runner de CI |

---

### Ejercicio B — Ramas y merge

> Completa primero: learngitbranching → Main → Introduction Sequence 3 y 4.

**Qué debes lograr:** que la función `blink_once` tenga un cuerpo implementado (aunque sea pseudocódigo) y que ese trabajo haya llegado a `main` a través de una rama de feature.

**Restricciones que comprueba la CI:**

- La rama debe llamarse exactamente **`feat/blink-led`**.
- La implementación de `blink_once` debe estar en un commit hecho sobre esa rama.
- La rama debe estar fusionada en `main` antes de la entrega.
- La función `blink_once` no debe seguir siendo un placeholder en `main` — el validador comprueba que el cuerpo tiene contenido real.

**Pistas:**

- Si nunca has creado una rama, el simulador de learngitbranching te lo explica visualmente antes de que lo hagas aquí.
- Tras el merge, comprueba con `git log --oneline --graph` que el historial refleja la bifurcación y la fusión.
- Una vez mergeada, la rama local ya no es necesaria.

**Comprueba tu progreso:**

| Dónde | Cómo | Qué debes ver |
|-------|------|---------------|
| Local | `bash scripts/check_git.sh` | Checks de `feat/blink-led` y `blink_once implementada` en verde |
| Remoto | `git push` → pestaña **Actions** → `check_git.yml` | Todos los checks de A y B en verde |

---

### Ejercicio C — Navegación por el historial

> Completa primero: learngitbranching → Main → Ramping Up 1 y 2.

**Qué debes lograr:** entender cómo moverse por el historial sin modificarlo.

No hay entregable para la CI — el objetivo es que puedas responder estas preguntas usando solo el terminal:

- ¿Cuál es el SHA corto del primer commit de este repositorio?
- ¿Qué archivos cambiaron hace exactamente 2 commits respecto al estado actual?
- ¿Qué diferencia hay entre usar `^` y `~` para referenciar ancestros?

**Pistas:**

- `git log` tiene opciones para filtrar, acotar y dar formato a la salida. Explóralas con `--help`.
- `git show` y `git diff` son tus principales herramientas aquí.
- Puedes combinar referencias relativas con cualquier comando que acepte un commit.

> Este ejercicio es exploratorio y no genera entregables nuevos. No es necesario hacer push ni ejecutar el validador al terminar.

---

### Ejercicio D — Tag de versión

> Completa primero: learngitbranching → Main → A Mixed Bag 1.

**Qué debes lograr:** marcar el estado de entrega con una etiqueta permanente visible en GitHub.

**Restricción que comprueba la CI:** el tag debe llamarse exactamente **`v0.1-lab0`** y estar publicado en el remoto.

**Pistas:**

- Crea el tag cuando el historial esté como quieres entregarlo — un tag apunta a un commit concreto.
- Los tags no se suben automáticamente con `git push`; necesitas un paso adicional explícito.
- Comprueba en la pestaña **Tags** de tu repositorio en GitHub que aparece antes de dar por cerrado este ejercicio.

**Comprueba tu progreso:**

| Dónde | Cómo | Qué debes ver |
|-------|------|---------------|
| Local | `git tag` | El tag `v0.1-lab0` aparece en la lista |
| Remoto | Publicar el tag → pestaña **Tags** en GitHub | El tag `v0.1-lab0` visible en GitHub |
| CI | Pestaña **Actions** → `check_git.yml` | Check del tag en verde (la CI se dispara al publicar el tag) |

---

### Ejercicio E — Pull Request en GitHub

> Completa primero: learngitbranching → Remote → Push & Pull 1, 2, 3 y 4.

**Qué debes lograr:** implementar `blink_n_times` en `sandbox/blink.c` sobre una rama de feature, publicarla en GitHub y fusionarla en `main` mediante un Pull Request — sin usar `git merge` en local.

**Restricciones que comprueba la CI:**

- La rama debe llamarse exactamente **`feat/blink-n-times`**.
- La función `blink_n_times` debe tener un cuerpo (puede ser pseudocódigo en comentarios).
- La fusión debe hacerse a través de la interfaz de Pull Requests de GitHub.

**Pistas:**

- Crea la rama a partir de `main` cuando ya tengas el tag `v0.1-lab0` puesto.
- Al publicar la rama por primera vez establece el seguimiento con el remoto desde ese mismo push.
- En GitHub, abre el PR desde la pestaña **Pull requests** apuntando a `main` de tu repositorio.
- Comprueba que los checks de la CI están en verde antes de pulsar el botón de merge.
- El título del PR debe describir el cambio que aporta, no ser genérico (`"lab0"` o `"entrega"` no son títulos válidos).

**Comprueba tu progreso:**

| Momento | Dónde | Qué debes ver |
|---------|-------|---------------|
| Rama creada (local) | `bash scripts/check_git.sh` | Check de `feat/blink-n-times` en verde — la rama existe aunque no esté mergeada aún |
| Al publicar la rama | Pestaña **Actions** en la rama `feat/blink-n-times` | `check_git.yml` en verde |
| Antes de pulsar merge | Panel de checks del PR en GitHub | CI en verde — si hay ❌, corrige y haz push a la rama |
| Tras el merge | `bash scripts/check_git.sh` desde `main` | Check reporta la rama como mergeada; todos los checks en verde |
| Tras el merge | Pestaña **Actions** en `main` | `check_git.yml` pasa con todos los checks, incluido `feat/blink-n-times` |

---

## Integración continua

Cada push lanza el validador automáticamente:

| Workflow | Disparador | Qué comprueba |
|----------|-----------|----------------|
| `check_git.yml` | Cualquier push | Nº de commits, formato de mensajes, ramas `feat/blink-led` y `feat/blink-n-times`, tag `v0.1-lab0`, ausencia de binarios |

Puedes ejecutar el mismo validador en local antes de hacer push:

```bash
bash scripts/check_git.sh
```

> Ejecuta siempre el validador desde la rama `main` para ver el estado completo. Si lo ejecutas desde una rama de feature, algunos checks pueden aparecer incompletos hasta que hagas el merge.

---

## Hitos sugeridos

| Hito | Criterio de éxito |
|------|--------------------|
| H1 — Identidad configurada | `git config user.name` muestra tu nombre real |
| H2 — Tres commits | `git log --oneline` muestra ≥ 3 commits con formato Conventional Commits |
| H3 — Rama mergeada | `feat/blink-led` fusionada en `main`; historial en grafo coherente |
| H4 — Tag publicado | `v0.1-lab0` visible en la pestaña Tags de GitHub |
| H5 — PR mergeado | `feat/blink-n-times` fusionada en `main` vía PR; CI en verde |

---

## Errores frecuentes

- **Commit con todos los cambios juntos** — un commit que toca cinco archivos por razones distintas es difícil de revertir y de entender. Un cambio coherente, un commit.
- **Mensaje genérico** — `"cambios"`, `"fix"`, `"wip"` no aportan información. El mensaje debe decir qué cambia y por qué.
- **Tag no publicado** — crear un tag local no es suficiente; hay que enviarlo al remoto explícitamente.
- **Binarios en el repositorio** — si `git status` muestra archivos `*.o`, `*.elf` o `*.bin`, revisa el `.gitignore` antes de hacer `add`.
- **`HEAD` en modo detached** — si el terminal muestra `HEAD detached at ...`, estás sobre un commit suelto, no sobre una rama. Vuelve a una rama antes de hacer nuevos commits.
- **Rama del PR con nombre incorrecto** — el validador busca exactamente `feat/blink-n-times`; cualquier variación no pasa la CI.

---

## Rúbrica

| Criterio | Peso |
|----------|-----:|
| Ejercicios A y B validados por la CI (`check_git.yml`) | 40 % |
| Ejercicio E: PR de `feat/blink-n-times` mergeado con CI en verde | 20 % |
| Tag `v0.1-lab0` publicado en GitHub | 20 % |
| Calidad de mensajes de commit (Conventional Commits, atómicos) | 20 % |
