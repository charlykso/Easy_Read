import React from 'react'
import { useLogout } from "../../hooks/useLogout";

const AuthUserBtn = ({ admin }) => {
    const { logout } = useLogout()

    const handleLogout = () => {
      logout()
    }
    return (
      <div className='relative text-white'>
        <select
          onChange={(e) => {
            if (e.target.value === "Sign out") {
              handleLogout()
            }
          }}
          className=' p-2.5 text-white-500 bg-purple-800 border rounded-md shadow-sm outline-none appearance-none focus:border-white'
        >
          <option disabled selected>
            Admin
          </option>
          <option value='Sign out'>
            <button>SIgn out</button>
          </option>
        </select>
      </div>
    )
}
 
export default AuthUserBtn;