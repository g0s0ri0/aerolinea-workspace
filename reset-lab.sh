#!/usr/bin/env bash
set -e

PROJECT_DIR="${1:-$PWD}"
cd "$PROJECT_DIR"

pkill -f "port-forward" 2>/dev/null || true
k3d cluster delete --all 2>/dev/null || true
docker-compose down -v --remove-orphans
docker container prune -f
docker network prune -f

echo "Entorno limpio en $PROJECT_DIR. Puertos revisados:"
ss -tulpn 2>/dev/null | grep -E ':(80|443|8080|8081|3306|6379)\b' || echo "Ninguno de los puertos clave está en uso."
