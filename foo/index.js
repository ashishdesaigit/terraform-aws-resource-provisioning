const AWS = require('aws-sdk');



exports.handler = async (event) => {

    const setting = {
        region : 'us-west-2'
    };

    const ddb = new AWS.DynamoDB.DocumentClient(setting);

    const data = {
            TableName :  process.env.consultants_table_name  ,
            Key : {
                id : '1'
            }
        };

        return ddb.get(data).promise()
            .then(result => {
                console.log(result);
                if( !result.Item.allocations){
                    result.Item.allocations = [];
                }
                const response = {
                    statusCode: 200,
                    headers: {
                        "Access-Control-Allow-Origin": "*"
                    },
                    body: JSON.stringify(result.Item)
                }
                return response;
            })
            .catch(error => {
                const response = {
                    statusCode: error.statusCode,
                    body: error.message
                }
                return response;
            });

}