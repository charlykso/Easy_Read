// import Draw2 from '../../images/draw2.svg'
import Reading from '../../images/reading_book_in_library.jpg'
import { useRef, useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
import { useNavigate } from 'react-router-dom'
import axios from '../../api/axios'
import { useAuthContext } from '../../hooks/useAuthContext'

const LOGIN_URL = '/login'

const Login = () => {
  const navigate = useNavigate()
  const userRef = useRef()
  const errRef = useRef()
  const [Phone_no, setPhone_no] = useState('')
  const [Password, setPassword] = useState('')
  const [errMsg, setErrMsg] = useState(null)
  const [checked, setChecked] = useState(false)
  const { dispatch } = useAuthContext()
  const [onload, setOnload] = useState(null)

  useEffect(() => {
    userRef.current.focus()
  }, [])

  useEffect(() => {
    setErrMsg('')
  }, [Phone_no, Password])

  const handleSubmit = async (e) => {
    e.preventDefault()
    setOnload(true)
    setErrMsg(null)
    let phoneLen = Phone_no.length
    let phoneWithCode = '+234'
    let userData = {}
    if (Phone_no.charAt(0) === '0') {
      for (var i = 1; i < phoneLen; i++) {
        phoneWithCode = phoneWithCode.concat(Phone_no.charAt(i))
      }
      // Phone_no = phoneWithCode
      userData = { Phone_no, phoneWithCode }
    } else {
      userData = { Phone_no, Password }
    }

    try {
      const response = await axios.post(LOGIN_URL, userData, {
        headers: { 'Content-type': 'application/json' },
      })
      const json = await response.data
      if(json.Role === "Admin")
      {
      //save token and expiry date
      localStorage.setItem('token', json.token)
      //save to local storage
      localStorage.setItem('user', JSON.stringify(json))
      //update the AuthContext
      setOnload(true)
      dispatch({ type: 'LOGIN', payload: json })
      navigate('/')
      }else{
        setErrMsg('Unauthorized page')
        setOnload(false)
      }
    } catch (error) {
      if (!error.response) {
        setErrMsg('No server response')
        setOnload(false)
      } else if (error.response.status === 400) {
        setErrMsg('Missing Phone_no or Password')
        setOnload(false)
      } else if (error.response.status === 401) {
        setErrMsg('Unauthorized')
        setOnload(false)
      } else if (error.response.status === 404) {
        setErrMsg('User not found')
        setOnload(false)
      } else {
        setErrMsg('Login failed')
        setOnload(false)
      }
      errRef.current.focus()
    }
  }

  return (
    <section className='flex justify-center items-center min-h-screen'>
      <div className='container px-6 py-6 h-full'>
        <div className='flex justify-center items-center flex-wrap h-full g-6 text-gray-800'>
          <div className='md:w-8/12 lg:w-6/12 mb-12 md:mb-0'>
            <img src={Reading} className='w-full' alt='Phone' />
          </div>
          <div className='md:w-8/12 lg:w-5/12 lg:ml-20'>
            <p
              ref={errRef}
              className={errMsg ? 'errmsg text-red-600' : 'offscreen'}
              aria-live='assertive'
            >
              {errMsg}
            </p>
            <form onSubmit={handleSubmit}>
              {/* <!-- phone input --> */}
              <div className='mb-6'>
                <input
                  type='text'
                  className='form-control block w-full px-4 py-2 text-xl font-normal text-gray-700 bg-white bg-clip-padding border border-solid border-gray-300 rounded transition ease-in-out m-0 focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none'
                  placeholder='Phone no'
                  id='Phone_no'
                  ref={userRef}
                  onChange={(e) => setPhone_no(e.target.value)}
                  value={Phone_no}
                  required
                />
              </div>

              {/* <!-- Password input --> */}
              <div className='mb-6'>
                <input
                  type='Password'
                  className='form-control block w-full px-4 py-2 text-xl font-normal text-gray-700 bg-white bg-clip-padding border border-solid border-gray-300 rounded transition ease-in-out m-0 focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none'
                  placeholder='Password'
                  onChange={(e) => setPassword(e.target.value)}
                  value={Password}
                  required
                />
              </div>
              <div></div>

              <div className='flex justify-between items-center mb-6'>
                <div className='form-group form-check'>
                  <input
                    type='checkbox'
                    checked={checked}
                    onChange={(e) => setChecked(e.target.checked)}
                    className='form-check-input appearance-none h-4 w-4 border border-gray-300 rounded-sm bg-white checked:bg-blue-600 checked:border-blue-600 focus:outline-none transition duration-200 mt-1 align-top bg-no-repeat bg-center bg-contain float-left mr-2 cursor-pointer'
                    id='exampleCheck3'
                  />{' '}
                  <label
                    className='form-check-label inline-block text-gray-800'
                    htmlFor='exampleCheck2'
                  >
                    Remember me
                  </label>
                </div>
                <Link
                  to='#!'
                  className='text-blue-600 hover:text-blue-700 focus:text-blue-700 active:text-blue-800 duration-200 transition ease-in-out'
                >
                  Forgot Password?
                </Link>
              </div>

              {/* <!-- Submit button --> */}

              <button
                disabled={onload}
                type='submit'
                className='inline-block px-7 py-3 bg-blue-600 text-white font-medium text-sm leading-snug uppercase rounded shadow-md focus:outline-none focus:ring-0 w-full'
                data-mdb-ripple='true'
                data-mdb-ripple-color='light'
              >
                {onload ? 'Loading...' : 'Sign in'}
              </button>

              <div className='flex items-center my-4 before:flex-1 before:border-t before:border-gray-300 before:mt-0.5 after:flex-1 after:border-t after:border-gray-300 after:mt-0.5'>
                <p className='text-center font-semibold mx-4 mb-0'>OOO</p>
              </div>
            </form>
          </div>
        </div>
      </div>
    </section>
  )
}

export default Login
