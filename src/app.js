App= {
  loading:false,
  contracts:{},
  load: async () => {

    console.log("app loading..")
    await App.loadWeb3()   
    await App.loadAccount()
    await App.loadContract()
    await App.render()
    console.log("Test 1")
    await App.renderCheckins()
  },

  loadWeb3: async () => {
    if (typeof web3 !== 'undefined') {
      App.web3Provider = web3.currentProvider
      web3 = new Web3(web3.currentProvider)
    } else {
      window.alert("Please connect to Metamask.")
    }
    // Modern dapp browsers...
    if (window.ethereum) {
      window.web3 = new Web3(ethereum)
      try {
        // Request account access if needed
        await ethereum.enable()
        // Acccounts now exposed
        web3.eth.sendTransaction({/* ... */})
      } catch (error) {
        // User denied account access...
      }
    }
    // Legacy dapp browsers...
    else if (window.web3) {
      App.web3Provider = web3.currentProvider
      window.web3 = new Web3(web3.currentProvider)
      // Acccounts always exposed
      web3.eth.sendTransaction({/* ... */})
    }
    // Non-dapp browsers...
    else {
      console.log('Non-Ethereum browser detected. You should consider trying MetaMask!')
    }
  },

  loadAccount : async () =>{
    App.account = web3.eth.accounts[0]
},

  loadContract : async () =>{
    const tracker = await $.getJSON('Tracker.json')
    App.contracts.Tracker = TruffleContract(tracker)
    App.contracts.Tracker.setProvider(App.web3Provider) 
    console.log(tracker)

    // Hydrate the smart contract with values from the blockchain
    App.tracker = await App.contracts.Tracker.deployed()
  },

  render : async () =>{
    //Prevent double rendering 
    if(App.loading){
      return
    }

    App.setLoading(true)

    $('#account').html(App.account)

    App.setLoading(false)
  },
  setLoading: (boolean) => {
    App.loading = boolean
    const loader = $('#loader')
    const content = $('#content')
    if (boolean) {
      loader.show()
      content.hide()
    } else {
      loader.hide()
      content.show()
    }
  },
  
  renderCheckins: async () =>{
    const Identification = await App.tracker.getAadharInfo(123456)
    const $CheckinTemplate = $('.CheckinTemplate')

    for(var i = 0; i<Identification.length;i++){
        var index = Identification[i].toNumber()
      
        console.log(Identification[i].toNumber())
        const checkinfo = await App.tracker.getCheckinInfo(index)
        const aadharNo = checkinfo[0].toNumber()
        const name = checkinfo[1]
        const address = checkinfo[2]
        const stateOfSector = checkinfo[3]
        const timestamp = new Date(checkinfo[4].toNumber())
        const temp = checkinfo[5]
        const sector = checkinfo[6]

       document.getElementById("CheckinTemplates").style.border = "thin solid #000000";
       document.getElementById("CheckinTemplates").style.marginTop = "5px";
       document.getElementById("Checkin").style.marginRight = "500px";
        const $newCheckinTemplate = $CheckinTemplate.clone()
        $newCheckinTemplate.find('.Checkindata').html
        ("Aadhar Number- " + aadharNo+"<br />"+
        "Name- "+name +"<br />"+
        "Address- "+address +"<br />"+
        "State Of Sector- "+stateOfSector+"<br />"+
        "CheckIn Time- "+timestamp+"<br />"+
        "Temperature- "+temp+"<br />"+
        "Sector- "+sector)

        $('#CheckinList').append($newCheckinTemplate)
        $newCheckinTemplate.show()

    }

    //await App.tracker.CreateCheckin(123456,"add4","Add1","Yellow","98.6","5")


    const test3 = await App.tracker.getCheckinInfo(1)
    ///console.log(test)

    //console.log(test3)
    //console.log(Identification)
  },

}

$(()=> {
  $(window).load(()=>{
      App.load()
  })
})
