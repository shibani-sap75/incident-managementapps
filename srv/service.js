const cds = require('@sap/cds')

module.exports = class ProcessorService extends cds.ApplicationService {
  init() {

    const { Incidents, Customer } = cds.entities('ProcessorService')

    this.before('CREATE', Incidents, async (req) => {
      //  console.log('Before CREATE/UPDATE Incidents', req.data)
      let urgent = req.data.title?.match(/urgent/i)
      // req.data.title?.match(/urgent/i)
      if (urgent) req.data.urgency_code = 'H'
    })


    this.after('READ', Incidents, async (incidents, req) => {
      //console.log('After READ Incidents', incidents)
      if (req.params && req.params.length > 0) {

        const ID = req.params[0].ID

        //  console.log('Requested Incident ID:', ID)

        const incident = await SELECT.one
          .from(Incidents)
          .columns('ID', 'status_code')
          .where({ ID })

        //  console.log('DB Incident:', incident)

        if (incident?.status_code === 'C') {
          return req.reject(
            400,
            `Incident ${ID} is already closed and cannot be read.`
          )
        }
      }
    })
    this.before(['CREATE', 'UPDATE'], Customer, async (req) => {
      console.log('Before CREATE/UPDATE Customer', req.data)
    })
    this.after('READ', Customer, async (customer, req) => {
      console.log('After READ Customer', customer)
    })


    return super.init()
  }
}
