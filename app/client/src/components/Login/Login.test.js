import React,{useState} from 'react';
import { render, fireEvent } from '@testing-library/react';
import { MDBInput } from 'mdbreact';

// NOTE: suppress virtual console output
console.error = ()=>{};

function CostInput () {
    const [value, setValue] = useState('')

    function removeDuplicateAT(email) {
        let string = '';
        let counter = 0;

        for (const char of email) {
            if(char !=='@') {
                string +=char;
            }
            if(char ==='@' && counter <1) {
                counter ++;
                string +=char;
            }
        }
        return string;
    }

    const handleChange = (ev)  =>{
        ev.preventDefault()
        const inputtedValue = ev.currentTarget.value
        const email = removeDuplicateAT(inputtedValue)
        setValue(email)
    }
    return <MDBInput aria-label="Email:" label="Email:"icon="envelope" group type="email" validate error="wrong" success="right" value={value} onChange={handleChange} size={"lg"} className={""}/>
}

const setup = () => {
    const utils = render(<CostInput />)
    const input = utils.getByLabelText('Email:')
    return {
      input,
      ...utils,
    }
  }

  test('It should remove @ if it is more than one', () => {
    const {input} = setup()
    fireEvent.change(input, {target: {value: 'can@@hotmail.de'}})
    expect(input.value).toBe('can@hotmail.de')
  })
