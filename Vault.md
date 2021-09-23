# Vault

The `private` modifier only means that you're unable to access the variable through the contract's ABI. We can still look at the data by reading the instance's storage data directly. Anything that needs to be hidden must be encrypted before putting it on the blockchain.

```javascript
// Get the variable stored in slot 1 at the instance address. The slots are zero-indexed and
// the password is the variable that was declared second so it exists in slot 1.
const password = await web3.eth.getStorageAt(instance, 1)
await contract.unlock(password)
```