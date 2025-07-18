#!/bin/bash

# Script de deploy para Kubernetes
# Substitua SEU_USUARIO pelo seu usuário do Docker Hub

DOCKER_USERNAME=${1:-"SEU_USUARIO"}
NAMESPACE="cliente-pet"

echo "🚀 Iniciando deploy da aplicação Cliente Pet no Kubernetes..."
echo "📦 Usando imagem: $DOCKER_USERNAME/cliente-pet:latest"

# Criar namespace
echo "📁 Criando namespace..."
kubectl apply -f namespace.yaml

# Aplicar ConfigMap
echo "⚙️  Aplicando ConfigMap..."
kubectl apply -f configmap.yaml

# Substituir usuário do Docker Hub no deployment
echo "🔧 Configurando deployment com usuário: $DOCKER_USERNAME"
sed "s/SEU_USUARIO/$DOCKER_USERNAME/g" deployment.yaml | kubectl apply -f -

# Aplicar Service
echo "🌐 Criando Service..."
kubectl apply -f service.yaml

# Aplicar Ingress
echo "🔗 Configurando Ingress..."
kubectl apply -f ingress.yaml

# Aplicar HPA
echo "📈 Configurando Auto Scaling..."
kubectl apply -f hpa.yaml

# Aguardar pods ficarem prontos
echo "⏳ Aguardando pods ficarem prontos..."
kubectl wait --for=condition=ready pod -l app=cliente-pet-api -n $NAMESPACE --timeout=300s

# Mostrar status
echo "✅ Deploy concluído!"
echo ""
echo "📊 Status dos recursos:"
kubectl get all -n $NAMESPACE

echo ""
echo "🌍 Para acessar a aplicação:"
echo "   - Adicione 'cliente-pet.local' ao seu /etc/hosts"
echo "   - Acesse: http://cliente-pet.local"
echo ""
echo "🔍 Para ver logs:"
echo "   kubectl logs -f deployment/cliente-pet-api -n $NAMESPACE"
echo ""
echo "📈 Para ver HPA:"
echo "   kubectl get hpa -n $NAMESPACE" 