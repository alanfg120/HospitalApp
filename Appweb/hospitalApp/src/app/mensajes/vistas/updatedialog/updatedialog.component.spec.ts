import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { UpdatedialogComponent } from './updatedialog.component';

describe('UpdatedialogComponent', () => {
  let component: UpdatedialogComponent;
  let fixture: ComponentFixture<UpdatedialogComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ UpdatedialogComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(UpdatedialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
