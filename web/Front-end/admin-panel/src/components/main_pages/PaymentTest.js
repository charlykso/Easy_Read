import React from 'react'
import { makePaymentUrl } from '../sub_pages/BaseUrl'
// import { useCreate } from '../../hooks/useCreate'
import { useFlutterwave, closePaymentModal } from 'flutterwave-react-v3'

const PaymentTest = () => {
  // const { createUser, error, isLoading } = useCreate()
  // let token = JSON.parse(localStorage.getItem('token'))
  // let jwt = token.token

  const config = {
    public_key: 'FLWPUBK_TEST-d0a7243b0274ed968f9c195b9c326a19-X',
    tx_ref: Date.now(),
    amount: 7000,
    currency: 'NGN',
    payment_options: 'card,mobilemoney,ussd',
    customer: {
      email: 'user@gmail.com',
      phone_number: '070********',
      name: 'john doe',
    },
    customizations: {
      title: 'my Payment Title',
      description: 'Payment for items in cart',
      logo: 'https://st2.depositphotos.com/4403291/7418/v/450/depositphotos_74189661-stock-illustration-online-shop-log.jpg',
    },
  }

  const handleFlutterPayment = useFlutterwave(config)

  return (
    <div className='App'>
      <h1>Hello Test user</h1>

      <button
        onClick={() => {
          handleFlutterPayment({
            callback: (response) => {
              var res = {
                status: response.status,
                transaction_id: response.transaction_id,
                amount: response.amount,
                eamil: response.customer.email,
                name: response.customer.name,
              }
              try {
                let formData = new FormData()
                formData.append('Status', response.status)
                formData.append('Transaction_Id', response.transaction_id)
                formData.append('Amount', response.amount)
                formData.append('Email', response.customer.email)
                formData.append('Name', response.customer.name)
                formData.append('User_Id', 13)
                formData.append('Book_Id', 5)
                // createUser(makePaymentUrl, formData, jwt)
                fetch(makePaymentUrl, {
                  method: 'post',
                  body: formData,
                })
                const data = response.text()
                console.log(data)
              } catch (error) {
                console.log(error.message)
              }
              console.log(res)
              closePaymentModal() // this will close the modal programmatically
            },
            onClose: () => {},
          })
        }}
      >
        Payment with React hooks
      </button>
    </div>
  )
}

export default PaymentTest
