param storageAccountName string
param staticWebsiteIndexContent string
param staticWebsiteErrorContent string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

resource staticWebsite 'Microsoft.Storage/storageAccounts/web@2021-04-01' = {
  parent: storageAccount
  name: 'default'
  properties: {
    indexDocument: 'index.html'
    errorDocument404Path: '404.html'
  }
}

resource indexHtml 'Microsoft.Storage/storageAccounts/blobServices/containers/blobs@2021-04-01' = {
  parent: staticWebsite
  name: 'index.html'
  properties: {
    content: base64(staticWebsiteIndexContent)
    contentType: 'text/html'
  }
}

resource errorHtml 'Microsoft.Storage/storageAccounts/blobServices/containers/blobs@2021-04-01' = {
  parent: staticWebsite
  name: '404.html'
  properties: {
    content: base64(staticWebsiteErrorContent)
    contentType: 'text/html'
  }
}
