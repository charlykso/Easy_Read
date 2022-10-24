import DeletePaymentModal from './DeletePaymentModal'
import Delete from '../../images/icons/recycle-bin.png'
import { Link } from "react-router-dom";

const PaymentList = ({payments}) => {
  return (
    <div className='flex flex-col'>
      <div className='overflow-x-auto sm:-mx-6 lg:-mx-8'>
        <div className='py-2 inline-block min-w-full sm:px-6 lg:px-8'>
          <div className='overflow-hidden'>
            <table className='min-w-full mb-2'>
              <thead className='bg-white border-b'>
                <tr>
                  <th
                    scope='col'
                    className='text-sm font-medium text-gray-900 px-6 py-4 text-left'
                  >
                    S/N
                  </th>
                  <th
                    scope='col'
                    className='text-sm font-medium text-gray-900 px-6 py-4 text-left'
                  >
                    Name
                  </th>
                  <th
                    scope='col'
                    className='text-sm font-medium text-gray-900 px-6 py-4 text-left'
                  >
                    Amount
                  </th>
                  <th
                    scope='col'
                    className='text-sm font-medium text-gray-900 px-6 py-4 text-left'
                  >
                    Book Title
                  </th>
                  <th
                    scope='col'
                    className='text-sm font-medium text-gray-900 px-6 py-4 text-left'
                  >
                    Status
                  </th>
                  <th
                    scope='col'
                    className='text-sm font-medium text-gray-900 px-6 py-4 text-left'
                  >
                    Payed At
                  </th>
                  <th
                    scope='col'
                    className='text-sm font-medium text-gray-900 px-6 py-4 text-center'
                  >
                    Action
                  </th>
                </tr>
              </thead>
              <tbody>
                {payments.map((payment, index) => (
                  <tr
                    className='bg-white border-b transition duration-300 ease-in-out hover:bg-gray-100'
                    key={payment.Id}
                  >
                    <td className='px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900'>
                      {index + 1}
                    </td>
                    <td className='text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap'>
                      {payment.User.Firstname} {payment.User.Lastname}
                    </td>
                    <td className='text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap'>
                      #{payment.Amount}
                    </td>
                    <td className='text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap'>
                      {payment.Book.Title}
                    </td>
                    <td className='text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap'>
                      {payment.Payment_Status}
                    </td>
                    <td className='text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap'>
                      {payment.Payment_made_at}
                    </td>
                    <td className='text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap'>
                      <div className='flex justify-center'>
                        <Link
                          className='btn btn-danger'
                          tabIndex={payment.Id}
                          data-bs-toggle='modal'
                          data-bs-target={`#exampleModal${payment.Id}`}
                          to='#'
                        >
                          <img
                            src={Delete}
                            alt='Delete'
                            className='w-6 h-6 m-0'
                          />
                        </Link>
                      </div>
                      <DeletePaymentModal
                        exampleModal={`exampleModal${payment.Id}`}
                        paymentId={payment.Id}
                      />
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  )
}

export default PaymentList
