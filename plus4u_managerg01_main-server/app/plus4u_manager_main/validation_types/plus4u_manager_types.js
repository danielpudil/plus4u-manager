const loginDtoInType = shape({
    code1: string(200).isRequired,
    code2: string(200).isRequired
});

const listActivitiesDtoInType = shape({
  code1: string(200).isRequired,
  code2: string(200).isRequired
});

const sendMessageDtoInType = shape({
  code1: string(200).isRequired,
  code2: string(200).isRequired,
  uri : string(200).isRequired,
  p4u_id : string(200).isRequired,
  message : string(200).isRequired,
});

const setStateDtoInType = shape({
  code1: string(200).isRequired,
  code2: string(200).isRequired,
  activityUri : string(200).isRequired,
  activityStateType : string(20).isRequired,
  comment : string(200),
});

const findPersonByParametersDtoInType = shape({
  code1: string(200).isRequired,
  code2: string(200).isRequired,
  clientName : string(200).isRequired
});

const getActivityListDtoInType = shape({
  code1: string(200).isRequired,
  code2: string(200).isRequired,
});

const changeCredentialsDtoInType = shape({
  oldCode1: string(200).isRequired,
  oldCode2: string(200).isRequired,
  newCode1: string(200).isRequired,
  newCode2: string(200).isRequired,
});

const createActivityDtoInType = shape({
  code1: string(200).isRequired,
  code2: string(200).isRequired,
  name: string(200).isRequired,
  artifactUri: string(200).isRequired,
  description: string(200),
  timeFrom: string(200).isRequired,
  timeTo: string(200).isRequired,
  action: string(200).isRequired
});
