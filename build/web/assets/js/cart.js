// Cart functionality
function updateQuantity(productId, quantity) {
    if (quantity < 1) {
        removeFromCart(productId);
        return;
    }
    
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = 'cart';
    
    const actionInput = document.createElement('input');
    actionInput.type = 'hidden';
    actionInput.name = 'action';
    actionInput.value = 'update';
    
    const productIdInput = document.createElement('input');
    productIdInput.type = 'hidden';
    productIdInput.name = 'productId';
    productIdInput.value = productId;
    
    const quantityInput = document.createElement('input');
    quantityInput.type = 'hidden';
    quantityInput.name = 'quantity';
    quantityInput.value = quantity;
    
    form.appendChild(actionInput);
    form.appendChild(productIdInput);
    form.appendChild(quantityInput);
    
    document.body.appendChild(form);
    form.submit();
}

function removeFromCart(productId) {
    if (confirm('Bạn có chắc muốn xóa sản phẩm này?')) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = 'cart';
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'remove';
        
        const productIdInput = document.createElement('input');
        productIdInput.type = 'hidden';
        productIdInput.name = 'productId';
        productIdInput.value = productId;
        
        form.appendChild(actionInput);
        form.appendChild(productIdInput);
        
        document.body.appendChild(form);
        form.submit();
    }
}