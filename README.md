http://localhost:3000/insurance/api/blocks
{
    noOfLastBlocks: 5
}

[{"id":"1","fingerprint":"817571615d946de4ea22","transactions":[{"type":3,"timestamp":"2019-09-30T12:31:47.322Z"}]},{"id":"0","fingerprint":"57c3c896870c41606199","transactions":[{"type":1,"timestamp":"2019-09-30T12:31:18.000Z"}]}]


http://localhost:3000/socket.io/?EIO=3&transport=polling&t=Ms2AK4d
http://localhost:3000/socket.io/?EIO=3&transport=polling&t=Ms2AK5c&sid=tPHaqUXipsSQ5ktOAAAB
http://localhost:3000/socket.io/?EIO=3&transport=polling&t=Ms2AK5f&sid=tPHaqUXipsSQ5ktOAAAB


ws://localhost:3000/socket.io/?EIO=3&transport=websocket&sid=tPHaqUXipsSQ5ktOAAAB
ws://localhost:3000/socket.io/?EIO=3&transport=websocket&sid=-_MoHeqa029SOobKAAAC
ws://localhost:3000/socket.io/?EIO=3&transport=websocket&sid=bNHGo7yolqqvSzjbAAAD


http://localhost:3000/insurance/api/claims
{
    status: "N"
}

[]


http://localhost:3000/insurance/api/contract-types
{

}

[{"uuid":"17210a72-f505-42bf-a238-65c8898477e1","shopType":"P","formulaPerDay":"price * 0.001 + 5.00","maxSumInsured":1500,"theftInsured":true,"description":"Phone Insurance Contract","conditions":"Exemplary contract terms here.","active":true,"minDurationDays":5,"maxDurationDays":10},{"uuid":"17d773dc-2624-4c22-a478-87544dd0a17f","shopType":"P","formulaPerDay":"price * 0.005 + 10.00","maxSumInsured":2500,"theftInsured":true,"description":"Premium SmartPhone Insurance","conditions":"Only for premium phone owners.","active":true,"minDurationDays":10,"maxDurationDays":20},{"uuid":"1d640cf7-9808-4c78-b7f0-55aaad02e9e5","shopType":"B","formulaPerDay":"price * 0.02","maxSumInsured":3500,"theftInsured":false,"description":"Insure Your Bike","conditions":"Simple contract terms.","active":true,"minDurationDays":3,"maxDurationDays":10},{"uuid":"63ef076a-33a1-41d2-a9bc-2777505b014f","shopType":"B","formulaPerDay":"price * 0.01 + 0.05","maxSumInsured":4300,"theftInsured":true,"description":"Contract for Mountain Bikers","conditions":"Contract Terms here","active":true,"minDurationDays":1,"maxDurationDays":7},{"uuid":"c06f95d6-9b90-4d24-b8cb-f347d1b33ddf","shopType":"BPS","formulaPerDay":"50","maxSumInsured":3000,"theftInsured":false,"description":"Universal Insurance Contract","conditions":"Universal Contract Terms here. For all types of goods.","active":true,"minDurationDays":1,"maxDurationDays":10},{"uuid":"d804f730-8c77-4583-9247-ec9e753643db","shopType":"S","formulaPerDay":"25.00","maxSumInsured":5000,"theftInsured":false,"description":"Short-Term Ski Insurance","conditions":"Simple contract terms here.","active":true,"minDurationDays":3,"maxDurationDays":25},{"uuid":"dcee27d7-bf3c-4995-a272-8a306a35e51f","shopType":"S","formulaPerDay":"price * 0.001 + 10.00","maxSumInsured":3000,"theftInsured":true,"description":"Insure Ur Ski","conditions":"Just do it.","active":true,"minDurationDays":1,"maxDurationDays":15}]




http://localhost:3000/shop/api/enter-contract
{
    additionalInfo: {item: {id: 0, brand: "Canyon", model: "Spectral AL 6.0", price: 3420, serialNo: "GWX46"},…}
endDate: "2019-09-26T18:30:00.000Z"
item: {id: 0, brand: "Canyon", model: "Spectral AL 6.0", price: 3420, serialNo: "GWX46"}
brand: "Canyon"
id: 0
model: "Spectral AL 6.0"
price: 3420
serialNo: "GWX46"
startDate: "2019-09-18T18:30:00.000Z"
contractTypeUuid: "63ef076a-33a1-41d2-a9bc-2777505b014f"
user: {username: "test", firstName: "tt", lastName: "test"}
firstName: "tt"
lastName: "test"
username: "test"
}

{"success":"Contract signed.","loginInfo":{"username":"test","password":"pass76","uuid":"d3687ddd-5310-4936-af05-8bc6e0e50cb0"}}



http://localhost:3000/insurance/api/authenticate-user
{
    password: "pass76"
username: "test"
}

{"success":true}




http://localhost:3000/insurance/api/contracts
{
    password: "pass76"
username: "test"
}

{"success":true,"contracts":[{"uuid":"d3687ddd-5310-4936-af05-8bc6e0e50cb0","username":"test","item":{"id":0,"brand":"Canyon","model":"Spectral AL 6.0","price":3420,"description":"","serialNo":"GWX46"},"startDate":"2019-09-18T18:30:00Z","endDate":"2019-09-26T18:30:00Z","void":false,"contractTypeUuid":"63ef076a-33a1-41d2-a9bc-2777505b014f"}]}