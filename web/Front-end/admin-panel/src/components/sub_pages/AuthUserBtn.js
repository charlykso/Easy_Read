import React from 'react'
import { Link } from "react-router-dom";
import { useLogout } from '../../hooks/useLogout'

const AuthUserBtn = ({ admin }) => {
  const { logout } = useLogout()

  const handleLogout = () => {
    logout()
  }
  return (
    <div className='relative text-white'>
      <select
        onChange={(e) => {
          if (e.target.value === 'Sign out') {
            handleLogout()
          }
        }}
        className=' p-2.5 text-white-500 bg-purple-800 border rounded-md shadow-sm outline-none appearance-none focus:border-white'
      >
        <option value="">
          Admin
        </option>
        <option value='Sign out'>
          <h4><Link to="#">Sign out</Link></h4>
        </option>
      </select>
    </div>
  )
}

export default AuthUserBtn
