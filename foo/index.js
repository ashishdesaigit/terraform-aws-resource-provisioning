const {uuid} = require ('uuid');

exports.handler = async (event) => {

    return "This is dumbest lambda for FOO :-" + uuid.v4();

}