const {uuid} = require ('uuid');

exports.handler = async (event) => {

    return "This is simplest lambda for FOO :-" + uuid.v4();

}