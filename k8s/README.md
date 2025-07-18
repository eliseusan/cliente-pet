# Kubernetes Deployment - Cliente Pet API

Este diretório contém todos os arquivos necessários para fazer o deploy da aplicação Cliente Pet no Kubernetes usando Lens.

## 📋 Pré-requisitos

### 1. **Lens Desktop**
- Instale o [Lens Desktop](https://k8slens.dev/)
- Configure um cluster local (Docker Desktop, Minikube, ou Kind)

### 2. **kubectl**
- Instale o kubectl: https://kubernetes.io/docs/tasks/tools/
- Configure para acessar seu cluster

### 3. **Imagem Docker**
- Certifique-se de que a imagem está no Docker Hub
- Exemplo: `seuusuario/cliente-pet:latest`

## 🚀 Deploy Rápido

### **Opção 1: Script automatizado**
```bash
# Dar permissão de execução
chmod +x deploy.sh

# Executar deploy (substitua SEU_USUARIO)
./deploy.sh SEU_USUARIO
```

### **Opção 2: Deploy manual**
```bash
# 1. Criar namespace
kubectl apply -f namespace.yaml

# 2. Aplicar ConfigMap
kubectl apply -f configmap.yaml

# 3. Editar deployment.yaml e substituir SEU_USUARIO
# 4. Aplicar deployment
kubectl apply -f deployment.yaml

# 5. Aplicar service
kubectl apply -f service.yaml

# 6. Aplicar ingress
kubectl apply -f ingress.yaml

# 7. Aplicar HPA
kubectl apply -f hpa.yaml
```

## 📁 Estrutura dos Arquivos

```
k8s/
├── namespace.yaml      # Namespace para organizar recursos
├── configmap.yaml      # Configurações da aplicação
├── deployment.yaml     # Deployment com 2 réplicas
├── service.yaml        # Service ClusterIP
├── ingress.yaml        # Ingress para acesso externo
├── hpa.yaml           # Auto Scaling
├── deploy.sh          # Script de deploy
└── README.md          # Este arquivo
```

## 🔧 Configurações

### **Deployment**
- **Réplicas:** 2 (mínimo)
- **Recursos:** 512Mi RAM, 250m CPU (requests)
- **Limites:** 1Gi RAM, 500m CPU
- **Health Checks:** Liveness e Readiness probes

### **Auto Scaling (HPA)**
- **Mínimo:** 2 pods
- **Máximo:** 10 pods
- **CPU:** 70% de utilização
- **Memória:** 80% de utilização

### **Ingress**
- **Host:** cliente-pet.local
- **Path:** /
- **Tipo:** nginx

## 🌐 Acesso à Aplicação

### **1. Configurar hosts (Windows)**
```cmd
# Adicionar ao C:\Windows\System32\drivers\etc\hosts
127.0.0.1 cliente-pet.local
```

### **2. Configurar hosts (Linux/Mac)**
```bash
# Adicionar ao /etc/hosts
echo "127.0.0.1 cliente-pet.local" | sudo tee -a /etc/hosts
```

### **3. Acessar aplicação**
- **API:** http://cliente-pet.local/cliente-pet/api
- **H2 Console:** http://cliente-pet.local/cliente-pet/api/h2-console

## 📊 Monitoramento

### **Ver status no Lens:**
1. Abra o Lens
2. Conecte ao seu cluster
3. Vá para o namespace `cliente-pet`
4. Monitore pods, services e ingress

### **Comandos úteis:**
```bash
# Ver todos os recursos
kubectl get all -n cliente-pet

# Ver logs dos pods
kubectl logs -f deployment/cliente-pet-api -n cliente-pet

# Ver status do HPA
kubectl get hpa -n cliente-pet

# Ver ingress
kubectl get ingress -n cliente-pet

# Descrever pods
kubectl describe pods -l app=cliente-pet-api -n cliente-pet
```

## 🔄 Atualizações

### **Atualizar imagem:**
```bash
# Fazer rollout com nova imagem
kubectl set image deployment/cliente-pet-api cliente-pet-api=SEU_USUARIO/cliente-pet:latest -n cliente-pet

# Verificar rollout
kubectl rollout status deployment/cliente-pet-api -n cliente-pet
```

### **Escalar manualmente:**
```bash
# Aumentar réplicas
kubectl scale deployment cliente-pet-api --replicas=5 -n cliente-pet

# Verificar
kubectl get pods -n cliente-pet
```

## 🧹 Limpeza

### **Remover tudo:**
```bash
kubectl delete namespace cliente-pet
```

### **Remover recursos específicos:**
```bash
kubectl delete -f k8s/deployment.yaml
kubectl delete -f k8s/service.yaml
kubectl delete -f k8s/ingress.yaml
kubectl delete -f k8s/hpa.yaml
kubectl delete -f k8s/configmap.yaml
kubectl delete -f k8s/namespace.yaml
```

## 🐛 Troubleshooting

### **Pods não iniciam:**
```bash
# Verificar eventos
kubectl get events -n cliente-pet --sort-by='.lastTimestamp'

# Verificar logs
kubectl logs deployment/cliente-pet-api -n cliente-pet
```

### **Ingress não funciona:**
```bash
# Verificar se o nginx ingress está instalado
kubectl get pods -n ingress-nginx

# Verificar ingress
kubectl describe ingress cliente-pet-ingress -n cliente-pet
```

### **HPA não escala:**
```bash
# Verificar métricas
kubectl top pods -n cliente-pet

# Verificar HPA
kubectl describe hpa cliente-pet-hpa -n cliente-pet
``` 