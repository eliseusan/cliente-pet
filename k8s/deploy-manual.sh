#!/bin/bash

# Script de deploy manual - todos os comandos kubectl apply -f
# Execute este script a partir do diretório raiz do projeto

echo "🚀 Iniciando deploy manual da aplicação Cliente Pet no Kubernetes..."
echo "📁 Executando a partir do diretório: $(pwd)"

# Verificar se estamos no diretório correto
if [ ! -f "k8s/namespace.yaml" ]; then
    echo "❌ Erro: Execute este script a partir do diretório raiz do projeto (onde está o pom.xml)"
    exit 1
fi

echo ""
echo "📋 Aplicando todos os recursos Kubernetes..."

# 1. Criar namespace
echo "1️⃣  Criando namespace..."
kubectl apply -f k8s/namespace.yaml

# 2. Aplicar ConfigMap
echo "2️⃣  Aplicando ConfigMap..."
kubectl apply -f k8s/configmap.yaml

# 3. Aplicar Deployment
echo "3️⃣  Aplicando Deployment..."
kubectl apply -f k8s/deployment.yaml

# 4. Aplicar Service
echo "4️⃣  Aplicando Service..."
kubectl apply -f k8s/service.yaml

# 5. Aplicar Ingress
echo "5️⃣  Aplicando Ingress..."
kubectl apply -f k8s/ingress.yaml

# 6. Aplicar HPA
echo "6️⃣  Aplicando HPA (Auto Scaling)..."
kubectl apply -f k8s/hpa.yaml

echo ""
echo "⏳ Aguardando pods ficarem prontos..."
kubectl wait --for=condition=ready pod -l app=cliente-pet-api -n cliente-pet --timeout=300s

echo ""
echo "✅ Deploy manual concluído!"
echo ""
echo "📊 Status dos recursos:"
kubectl get all -n cliente-pet

echo ""
echo "🌍 Para acessar a aplicação:"
echo "   - Adicione 'cliente-pet.local' ao seu /etc/hosts"
echo "   - Acesse: http://cliente-pet.local"
echo ""
echo "🔍 Para ver logs:"
echo "   kubectl logs -f deployment/cliente-pet-api -n cliente-pet"
echo ""
echo "📈 Para ver HPA:"
echo "   kubectl get hpa -n cliente-pet" 