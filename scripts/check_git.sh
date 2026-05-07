#!/usr/bin/env bash
# Validación del historial Git — Lab 0
#
# Comprueba que el alumno ha completado los ejercicios prácticos inspeccionando
# el historial real del repositorio. No requiere clave secreta.
#
# Uso (desde la raíz del repositorio):
#   bash scripts/check_git.sh

set -euo pipefail

PASSED=0; FAILED=0

# ---------------------------------------------------------------------------
# Helper de resultado
# ---------------------------------------------------------------------------

check() {
    local desc="$1" result="$2" hint="${3:-}"
    if [[ "$result" == "ok" ]]; then
        printf "  ✅  %s\n" "$desc"
        PASSED=$(( PASSED + 1 ))
    else
        printf "  ❌  %s\n" "$desc"
        [[ -n "$hint" ]] && printf "       → %s\n" "$hint"
        FAILED=$(( FAILED + 1 ))
    fi
}

# ---------------------------------------------------------------------------
# Cabecera
# ---------------------------------------------------------------------------

echo ""
echo ".------------------------------------------------."
echo "|  Lab 0  .  Validador de historial Git          |"
echo "|  Git y GitHub  .  Ejercicios practicos         |"
echo "'------------------------------------------------'"
echo ""

# Aviso si el alumno no está en main
current_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")
if [[ "$current_branch" != "main" ]]; then
    echo "  ⚠️  Estás en la rama '$current_branch', no en 'main'."
    echo "     Algunos checks pueden dar resultados parciales."
    echo "     Ejecuta el validador desde 'main' para ver el estado completo."
    echo ""
fi

# ---------------------------------------------------------------------------
# E1 — Mínimo de commits en la rama actual
# ---------------------------------------------------------------------------

echo "  -- Ejercicio A . Commits basicos --"
echo ""

commit_count=$(git rev-list --count HEAD 2>/dev/null || echo "0")

if [[ "$commit_count" -ge 3 ]]; then
    check "Al menos 3 commits en la rama actual ($commit_count encontrados)" "ok"
else
    check "Al menos 3 commits en la rama actual" "fail" \
        "Solo $commit_count commit(s). Necesitas al menos 3 commits (uno por cada cambio del Ejercicio A)."
fi

# ---------------------------------------------------------------------------
# E2 — Mensajes en formato Conventional Commits
# ---------------------------------------------------------------------------

conv_pattern='^[a-f0-9]+ (feat|fix|docs|chore|test|style|refactor|perf|ci|build)(\([^)]+\))?!?: .+'

conv_count=0
while IFS= read -r line; do
    [[ "$line" =~ $conv_pattern ]] && conv_count=$(( conv_count + 1 ))
done < <(git log --oneline | head -20)

if [[ "$conv_count" -ge 3 ]]; then
    check "Al menos 3 commits con formato Conventional Commits ($conv_count encontrados)" "ok"
else
    check "Al menos 3 commits con formato Conventional Commits" "fail" \
        "Solo $conv_count válido(s). Formato: tipo(scope): descripción — ej. feat(lab0): add blink_init placeholder"
fi

# ---------------------------------------------------------------------------
# E3 — Rama feat/blink-led creada y mergeada
# ---------------------------------------------------------------------------

echo ""
echo "  -- Ejercicio B . Rama y merge --"
echo ""

branch_present=false

# Merge commit local (git merge desde terminal) o PR merge de GitHub
if git log --merges --oneline 2>/dev/null | grep -qi "blink-led"; then
    branch_present=true
fi
# Rama aún sin mergear pero existente (local o remota)
if git branch --list "feat/blink-led" 2>/dev/null | grep -q "feat/blink-led"; then
    branch_present=true
fi
if git branch -r 2>/dev/null | grep -q "feat/blink-led"; then
    branch_present=true
fi
# Commit cuyo mensaje menciona la rama (por si el alumno usó --no-ff o squash)
if git log --oneline --all 2>/dev/null | grep -qi "feat/blink-led\|blink-led"; then
    branch_present=true
fi
# Fallback para squash merge con mensaje limpio: el TODO del Ejercicio B ha desaparecido
# de sandbox/blink.c en main y el archivo tiene al menos 2 commits en su historial.
if ! $branch_present; then
    _squash_count=$(git log --oneline --all -- sandbox/blink.c 2>/dev/null | wc -l | tr -d ' ')
    if [[ "$_squash_count" -ge 2 ]] && \
       ! git show HEAD:sandbox/blink.c 2>/dev/null | grep -q "TODO (Ejercicio B)"; then
        branch_present=true
    fi
fi

if $branch_present; then
    check "Rama 'feat/blink-led' creada y mergeada en main" "ok"
else
    check "Rama 'feat/blink-led' creada y mergeada en main" "fail" \
        "Crea la rama con el nombre exacto 'feat/blink-led', implementa blink_once y fusiónala en main."
fi

# sandbox/blink.c modificado al menos en 2 commits distintos
blink_commit_count=$(git log --oneline --all -- sandbox/blink.c 2>/dev/null | wc -l | tr -d ' ')

if [[ "$blink_commit_count" -ge 2 ]]; then
    check "sandbox/blink.c modificado en ≥ 2 commits (encontrados: $blink_commit_count)" "ok"
else
    check "sandbox/blink.c modificado en ≥ 2 commits" "fail" \
        "Modifica blink.c en el Ejercicio A (en main) y en el Ejercicio B (en feat/blink-led)."
fi

if ! git show HEAD:sandbox/blink.c 2>/dev/null | grep -q "TODO (Ejercicio B)"; then
    check "blink_once implementada en main" "ok"
else
    check "blink_once implementada en main" "fail" \
        "La función blink_once sigue siendo un placeholder. Implementa el cuerpo en feat/blink-led y fusiónala en main."
fi

# ---------------------------------------------------------------------------
# E5 — Tag v0.1-lab0 existe
# ---------------------------------------------------------------------------

echo ""
echo "  -- Ejercicio D . Tag de version --"
echo ""

if git tag --list "v0.1-lab0" 2>/dev/null | grep -q "v0.1-lab0"; then
    check "Tag 'v0.1-lab0' existe" "ok"
else
    check "Tag 'v0.1-lab0' existe" "fail" \
        "Crea el tag con el nombre exacto 'v0.1-lab0' y publícalo en el remoto (los tags no se suben solos)."
fi

# ---------------------------------------------------------------------------
# E5 — Rama feat/blink-n-times creada y mergeada (Ejercicio E)
# ---------------------------------------------------------------------------

echo ""
echo "  -- Ejercicio E . Pull Request --"
echo ""

blink_n_present=false
blink_n_merged=false

# Merge commit: git merge local genera "Merge branch 'feat/blink-n-times'"
# GitHub PR merge genera "Merge pull request #N from .../feat/blink-n-times"
if git log --merges --oneline 2>/dev/null | grep -qi "blink-n-times"; then
    blink_n_merged=true
    blink_n_present=true
fi
# Rama local todavía sin mergear
if git branch --list "feat/blink-n-times" 2>/dev/null | grep -q "feat/blink-n-times"; then
    blink_n_present=true
fi
# Rama remota publicada
if git branch -r 2>/dev/null | grep -q "feat/blink-n-times"; then
    blink_n_present=true
fi
# Commit cuyo mensaje menciona la rama (squash merge)
if git log --oneline --all 2>/dev/null | grep -qi "feat/blink-n-times\|blink-n-times\|blink_n_times"; then
    blink_n_present=true
    # Si el commit está en main se considera mergeado
    if git log --oneline main 2>/dev/null | grep -qi "blink-n-times\|blink_n_times"; then
        blink_n_merged=true
    fi
fi
# Fallback para squash merge con mensaje limpio: el TODO del Ejercicio E ha desaparecido
# de sandbox/blink.c en main y el archivo acumula al menos 3 commits.
if ! $blink_n_merged; then
    _squash_count_e=$(git log --oneline main -- sandbox/blink.c 2>/dev/null | wc -l | tr -d ' ')
    if [[ "$_squash_count_e" -ge 3 ]] && \
       ! git show main:sandbox/blink.c 2>/dev/null | grep -q "TODO (Ejercicio E)"; then
        blink_n_merged=true
        blink_n_present=true
    fi
fi

if $blink_n_merged; then
    check "Rama 'feat/blink-n-times' mergeada en main vía PR" "ok"
elif $blink_n_present; then
    check "Rama 'feat/blink-n-times' mergeada en main vía PR" "fail" \
        "La rama existe pero aún no está mergeada en main. Abre el PR en GitHub y haz merge cuando la CI esté verde."
else
    check "Rama 'feat/blink-n-times' mergeada en main vía PR" "fail" \
        "Crea la rama con el nombre exacto, implementa 'blink_n_times' y fusiónala en main mediante un PR en GitHub."
fi

if ! git show HEAD:sandbox/blink.c 2>/dev/null | grep -q "TODO (Ejercicio E)"; then
    check "blink_n_times implementada en main" "ok"
else
    check "blink_n_times implementada en main" "fail" \
        "La función blink_n_times sigue siendo un placeholder. Añade pseudocódigo en feat/blink-n-times y fusiónala en main."
fi

# ---------------------------------------------------------------------------
# E7 — No hay archivos binarios ni compilados rastreados
# ---------------------------------------------------------------------------

echo ""
echo "  -- Buenas practicas --"
echo ""

bad_extensions=("*.elf" "*.axf" "*.bin" "*.hex" "*.out" "*.o" "*.a" "*.d")
bad_files=()

for ext in "${bad_extensions[@]}"; do
    while IFS= read -r f; do
        [[ -n "$f" ]] && bad_files+=("$f")
    done < <(git ls-files "$ext" 2>/dev/null || true)
done

if [[ ${#bad_files[@]} -eq 0 ]]; then
    check "No hay archivos binarios/compilados rastreados por Git" "ok"
else
    check "No hay archivos binarios/compilados rastreados por Git" "fail" \
        "Archivos detectados: ${bad_files[*]}. Deja de rastrearlos sin borrarlos del disco y añádelos al .gitignore."
fi

# ---------------------------------------------------------------------------
# Resumen final
# ---------------------------------------------------------------------------

TOTAL=$(( PASSED + FAILED ))

if [[ $TOTAL -gt 0 ]]; then
    SCORE=$(( PASSED * 10 / TOTAL ))
    filled=$(( PASSED * 20 / TOTAL ))
    bar=""
    for (( i=0; i<20; i++ )); do
        [[ $i -lt $filled ]] && bar+="█" || bar+="░"
    done
    pct=$(( PASSED * 100 / TOTAL ))
else
    SCORE=0; bar="░░░░░░░░░░░░░░░░░░░░"; pct=0
fi

echo ""
echo ".------------------------------------------------."
printf "|  Superados: %2d / %2d  .  Nota: %2d / 10%-10s|\n" \
    "$PASSED" "$TOTAL" "$SCORE" ""
printf "|  [%s]  %3d%%%-18s|\n" "$bar" "$pct" ""
echo "|                                                |"

if [[ $SCORE -eq 10 ]]; then
    echo "|  Historial impecable. El repo habla por ti. 🌳 |"
elif [[ $SCORE -ge 7 ]]; then
    echo "|  Buen progreso. Completa los ejercicios. 💪    |"
elif [[ $SCORE -ge 5 ]]; then
    echo "|  Vas por buen camino. Revisa los fallos.       |"
else
    echo "|  Sigue las instrucciones del README paso a paso|"
fi

echo "'------------------------------------------------'"
echo ""

[[ $FAILED -eq 0 ]] && exit 0 || exit 1
